import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/product_list.dart';

enum ProductFilter { Favorite, All }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                _isFavoriteOnly = value == ProductFilter.Favorite;
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: ProductFilter.Favorite,
                child: Text(
                  'Favorite Products',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              PopupMenuItem(
                value: ProductFilter.All,
                child: Text(
                  'All Products',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Consumer<Cart>(
              builder: (_, value, ch) => Badge.count(
                count: value.cart.length,
                alignment: AlignmentDirectional.bottomEnd,
                child: ch,
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routePath),
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductList(_isFavoriteOnly),
    );
  }
}
