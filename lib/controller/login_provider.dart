import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMsg = '';
  bool _isLogin = false;

  bool get isLoading => _isLoading;
  String get errorMsg => _errorMsg;
  bool get isLogin => _isLogin;

  Future<void> login(String name, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (password.isEmpty || password.length <= 5) {
        _isLogin = false;
        notifyListeners();
      } else {
        _isLogin = true;
        notifyListeners();
      }
    } catch (e) {
      _errorMsg = e.toString();
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
