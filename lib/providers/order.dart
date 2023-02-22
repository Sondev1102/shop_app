import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class Order {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> cart;

  Order(
      {required this.id,
      required this.amount,
      required this.dateTime,
      required this.cart});
}

class OrderList with ChangeNotifier {
  final List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  void addOrder(double amount, List<CartItem> cart) {
    _orderList.insert(
      0,
      Order(
          id: DateTime.now().toString(),
          amount: amount,
          dateTime: DateTime.now(),
          cart: cart),
    );

    notifyListeners();
  }
}
