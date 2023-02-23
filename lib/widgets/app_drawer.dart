import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_management.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Hi Friend!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Order'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrderScreen.routePath),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Product Management'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ProductManagement.routePath),
            ),
          ],
        ),
      ),
    );
  }
}
