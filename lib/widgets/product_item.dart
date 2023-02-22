import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productItem = Provider.of<Product>(context, listen: false);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                productItem.imageUrl,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productItem.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('\$${productItem.price}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    productItem.description,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          Consumer<Product>(
            builder: (context, product, child) => Column(
              children: [
                IconButton(
                  onPressed: () => product.toggleFavorite(),
                  icon: Icon(!product.isFavorite
                      ? Icons.favorite_border
                      : Icons.favorite),
                ),
                child as Widget,
              ],
            ),
            child: IconButton(
              onPressed: () => cart.addToCart(
                  productItem.id, productItem.price, productItem.title),
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
