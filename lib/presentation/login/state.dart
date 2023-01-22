import 'package:api_demo/repository/model/login/login_succes.dart';
import 'package:api_demo/repository/model/login_error.dart';
import 'package:api_demo/repository/use_case/login_use_case.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  String _email = '';
  String get email => _email;

  setEmail(p0) => _email = p0;

  String _password = '';
  String get password => _password;

  setPassword(p0) => _password = p0;

  bool _passHidden = true;
  bool get passHidden => _passHidden;

  setPassHidden() {
    _passHidden = !_passHidden;
    notifyListeners();
  }

  LoginSucces? _success;
  LoginSucces? get success => _success;

  LoginError? _error;
  LoginError? get error => _error;

  Future<void> get login async {
    _success = null;
    _error = null;
    var body = {"email": _email.trim(), "password": _password.trim()};

    final res = await doLogin(body);

    if (res.isLeft) {
      _success = res.left;
    } else {
      _error = res.right;
    }

    notifyListeners();
  }
}
