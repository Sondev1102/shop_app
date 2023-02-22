import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/order.dart';

class OrderItem extends StatefulWidget {
  final Order orderItem;
  OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
              DateFormat.yMd().add_jm().format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              onPressed: () => setState(
                () {
                  _isExpanded = !_isExpanded;
                },
              ),
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_isExpanded)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.orderItem.cart.length * 20 + 10, 100),
              child: ListView(
                children: [
                  const Divider(),
                  ...widget.orderItem.cart
                      .map((prd) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prd.title,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                  '${prd.quantity}x\$${prd.price.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          ))
                      .toList()
                ],
              ),
            ),
        ],
      ),
    );
  }
}
