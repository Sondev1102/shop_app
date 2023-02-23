import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop_app/providers/loading.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class AddEditProducts extends StatefulWidget {
  static const String routePath = '/add-edit-product';
  const AddEditProducts({super.key});

  @override
  State<AddEditProducts> createState() => _AddEditProductsState();
}

class _AddEditProductsState extends State<AddEditProducts> {
  TextEditingController _imageUrlController = TextEditingController();

  String _validateImageUrl = '';
  final _key = GlobalKey<FormState>();
  Product _initValue =
      Product(id: '', title: '', description: '', imageUrl: '', price: 0);

  void _onSaveForm(String value) {}

  void _onSubmit(context) async {
    Provider.of<Loading>(context, listen: false).ableLoading();
    try {
      await _validateImage();
      final isValidate =
          _key.currentState == null && _key.currentState!.validate();
      if (!isValidate) {
        return;
      }
      _key.currentState!.save();

      await Provider.of<Products>(context, listen: false)
          .addProduct(_initValue);
    } catch (err) {
      print(err.toString());
    } finally {
      Provider.of<Loading>(context, listen: false).disableLoading();

      Navigator.of(context).pop();
    }
    print('pop');
  }

  bool _checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }

  Future<void> _validateImage() async {
    if (_imageUrlController.text.isEmpty) {
      setState(() {
        _validateImageUrl = 'Please enter image URL!';
      });
    }
    http.Response res;
    try {
      res = await http.get(Uri.parse(_imageUrlController.text));
      Map<String, dynamic> data = res.headers;
      if (_checkIfImage(data['content-type']) == false ||
          res.statusCode != 200) {
        setState(() {
          _validateImageUrl = 'This is not a image url!';
        });
      } else {
        setState(() {
          _validateImageUrl = '';
        });
      }
    } catch (e) {
      setState(() {
        _validateImageUrl = 'Wrong URL!';
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<Loading>(context);
    print(loadingProvider.isLoading);

    Widget buildForm = Form(
      key: _key,
      child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter product title!';
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              _initValue = Product(
                  id: _initValue.id,
                  title: newValue as String,
                  description: _initValue.description,
                  imageUrl: _initValue.imageUrl,
                  price: _initValue.price);
            }),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Price'),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter product price!';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a validate number!';
              }
              if (double.parse(value) <= 0) {
                return 'Please enter a price greater than 0!';
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              _initValue = Product(
                  id: _initValue.id,
                  title: _initValue.title,
                  description: _initValue.description,
                  imageUrl: _initValue.imageUrl,
                  price: double.parse(newValue as String));
            }),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Description'),
            ),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter product description!';
              }
              if (value.length < 10) {
                return 'Please enter more than 10 characters!';
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              _initValue = Product(
                  id: _initValue.id,
                  title: _initValue.title,
                  description: newValue as String,
                  imageUrl: _initValue.imageUrl,
                  price: _initValue.price);
            }),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: _imageUrlController.text.isEmpty
                    ? const Center(
                        child: Text('Enter url!'),
                      )
                    : Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Focus(
                  onFocusChange: (value) {
                    if (!value) {
                      _validateImage();
                    }
                  },
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Image URL'),
                    ),
                    controller: _imageUrlController,
                    validator: (value) =>
                        _validateImageUrl.isEmpty ? null : _validateImageUrl,
                    onFieldSubmitted: (value) {
                      _onSubmit(context);
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSaved: (newValue) => setState(() {
                      _initValue = Product(
                          id: _initValue.id,
                          title: _initValue.title,
                          description: _initValue.description,
                          imageUrl: _imageUrlController.text,
                          price: _initValue.price);
                    }),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          actions: [
            IconButton(
              onPressed: () => _onSubmit(context),
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: loadingProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : buildForm,
        ),
      ),
    );
  }
}
