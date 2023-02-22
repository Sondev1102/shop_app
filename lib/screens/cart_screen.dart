import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/order_screen.dart';

class CartScreen extends StatelessWidget {
  static const String routePath = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<OrderList>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      cart.getAmount.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      if (cart.cart.isNotEmpty) {
                        order.addOrder(
                            cart.getAmount, cart.cart.values.toList());
                        cart.cleanCart();
                        Navigator.of(context).pushNamed(OrderScreen.routePath);
                      }
                    },
                    child: const Text(
                      'ORDER NOW',
                      style: TextStyle(color: Colors.purple),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final CartItem cartItem = cart.cart.values.toList()[index];
                return Dismissible(
                  onDismissed: (direction) {
                    cart.removeCartItem(cart.cart.keys.toList()[index]);
                  },
                  key: ValueKey(cartItem.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: FittedBox(
                            child: Text('\$${cartItem.price}'),
                          ),
                        ),
                      ),
                      title: Text(cartItem.title),
                      subtitle: Text(
                          'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                      trailing: Text('${cartItem.quantity} x'),
                    ),
                  ),
                );
              },
              itemCount: cart.cart.length,
            ),
          )
        ],
      ),
    );
  }
}
