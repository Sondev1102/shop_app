import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/loading.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_edit_products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_management.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Loading(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              labelMedium: TextStyle(
                fontSize: 18,
              ),
              labelSmall: TextStyle(fontSize: 14, color: Colors.grey)),
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          CartScreen.routePath: (context) => CartScreen(),
          OrderScreen.routePath: (context) => OrderScreen(),
          ProductManagement.routePath: (context) => ProductManagement(),
          AddEditProducts.routePath: (context) => AddEditProducts(),
        },
      ),
    );
  }
}
