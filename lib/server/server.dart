import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/loading.dart';

class Server {
  static const String baseUrl =
      'https://test-e8ef1-default-rtdb.firebaseio.com/';

  dynamic baseGet(String prefix) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + prefix),
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('get fail');
    }
  }

  Future basePost(Map<String, Object> value, String prefix) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + prefix),
        body: jsonEncode({...value}),
      );
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  Future baseDelete(String id, String prefix, BuildContext context) async {
    try {
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: const Text('Delete product'),
      //     content: Text('Are you sure to delete this product?'),
      //     actions: [
      //       TextButton(
      //         onPressed: () => Navigator.of(context).pop,
      //         child: Text('No'),
      //       ),
      //       TextButton(
      //         onPressed: () async {
      //           await http.delete(
      //             Uri.parse(baseUrl + prefix),
      //           );
      //           Navigator.of(context).pop();
      //         },
      //         child: Text('Yes'),
      //       ),
      //     ],
      //   ),
      // );
      await http.delete(
        Uri.parse(baseUrl + prefix),
      );
    } catch (e) {
      print("delete err");
    }
  }
}
