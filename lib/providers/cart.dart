import 'package:flutter/material.dart';

class CartItem {
  final String id;
  int quantity;
  final double price;
  final String title;

  CartItem(
      {required this.id,
      required this.price,
      required this.title,
      this.quantity = 0});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};

  Map<String, CartItem> get cart {
    return {..._cart};
  }

  double get getAmount {
    return _cart.values.fold(
      0.0,
      (previousValue, item) => (previousValue + item.price * item.quantity),
    );
  }

  void addToCart(String productId, double price, String title) {
    if (_cart.containsKey(productId)) {
      _cart.update(
        productId,
        (oldCartItem) => CartItem(
            id: DateTime.now().toString(),
            price: price,
            title: title,
            quantity: oldCartItem.quantity + 1),
      );
    } else {
      _cart.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void cleanCart() {
    _cart = {};
    notifyListeners();
  }

  void removeCartItem(String id) {
    _cart.removeWhere((key, value) => key == id);
    notifyListeners();
  }
}
