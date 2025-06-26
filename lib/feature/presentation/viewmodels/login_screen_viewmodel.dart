import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';

class LoginScreenViewmodel extends ChangeNotifier {
  final AuthUsecases usecases;

  LoginScreenViewmodel({required this.usecases});

  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isLoading => _isLoading;

  void onEmailChanged(String value) {
    _email = value.trim();
    _emailError = null;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _password = value;
    _passwordError = null;
    notifyListeners();
  }

  bool _validate() {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    final passwordRegex = RegExp(r'^.{6,}$');

    bool isValid = true;

    if (!emailRegex.hasMatch(_email)) {
      _emailError = 'Введите корректный email';
      isValid = false;
    }
    if (!passwordRegex.hasMatch(_password)) {
      _passwordError = 'Пароль должен быть не короче 6 символов';
      isValid = false;
    }
    notifyListeners();
    return isValid;
  }

  Future<void> login(BuildContext context) async {
    if (!_validate()) return;
    _isLoading = true;
    notifyListeners();
    final success = await usecases.login(_email, _password);
    if (!success) {
      _emailError = 'Ошибка регистрации';
    }
    else {
      context.router.replacePath("/boards");
    }
    _isLoading = false;
    notifyListeners();
  }
}
