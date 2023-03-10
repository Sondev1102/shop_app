import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/server/server.dart';

class Products with ChangeNotifier {
  static final Server _server = Server();
  static const String _prefix = 'products';
  static const String _end = '.json';
  List<Product> _products = [];
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchAndSetProducts() async {
    final Map<String, dynamic> response =
        await _server.baseGet(_prefix + _end) ?? {};
    final List<Product> _loadedProducts = [];
    response.forEach((prodId, prod) {
      _loadedProducts.add(
        Product(
          id: prodId,
          title: prod['title'],
          description: prod['description'],
          imageUrl: prod['imageUrl'],
          price: prod['price'],
        ),
      );
    });
    _products = _loadedProducts;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _server.basePost({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'isFavorite': product.isFavorite,
      'imageUrl': product.imageUrl,
    }, _prefix + _end);
    await this.fetchAndSetProducts();
    notifyListeners();
  }

  Future<void> deleteProduct(String productId, BuildContext context) async {
    await _server.baseDelete(
        productId, _prefix + '/' + productId + _end, context);
    await this.fetchAndSetProducts();
    notifyListeners();
  }
}
