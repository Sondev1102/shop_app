import 'package:flutter/material.dart';
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
              itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: ProductFilter.Favorite,
                      child: Text('Favorite Products'),
                    ),
                    PopupMenuItem(
                      value: ProductFilter.All,
                      child: Text('All Products'),
                    )
                  ])
        ],
      ),
      body: ProductList(_isFavoriteOnly),
    );
  }
}
