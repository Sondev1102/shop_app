import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/server/authServer.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  final _authServer = AuthServer();

  Future<void> _authenticate(
      String email, String password, bool isLogin) async {
    try {
      final response = await http.post(
        Uri.parse(isLogin ? _authServer.loginUrl : _authServer.signUpUrl),
        body: jsonEncode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, false);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, true);
  }
}
