import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_edit_products.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class ProductManagement extends StatelessWidget {
  static const String routePath = '/product-management';
  const ProductManagement({super.key});

  Future<void> _onFresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddEditProducts.routePath),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _onFresh(context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
            itemBuilder: (_, index) {
              final product = productsData.products[index];
              return ListTile(
                title: Text(product.title),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    product.imageUrl,
                  ),
                ),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () =>
                            Provider.of<Products>(context, listen: false)
                                .deleteProduct(product.id, context),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: productsData.products.length,
          ),
        ),
      ),
    );
  }
}
