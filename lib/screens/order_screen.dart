import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routePath = '/route';

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderList>(context);
    print(order.orderList.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final orderItem = order.orderList[index];
          return OrderItem(orderItem);
        },
        itemCount: order.orderList.length,
      ),
    );
  }
}
