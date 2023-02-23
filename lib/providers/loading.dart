import 'package:flutter/material.dart';

class Loading with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void ableLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void disableLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
