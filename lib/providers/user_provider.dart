import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

}