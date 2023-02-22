import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductList extends StatelessWidget {
  final isShowProductOnly;
  ProductList(this.isShowProductOnly);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context)
        .products
        .where((product) =>
            isShowProductOnly ? product.isFavorite == isShowProductOnly : true)
        .toList();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemBuilder: (_, i) {
          final productItem = products[i];
          return ChangeNotifierProvider.value(
            value: productItem,
            key: ValueKey(productItem.id),
            builder: (_, child) => ProductItem(),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
