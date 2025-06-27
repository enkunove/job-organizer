import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';

class RegistrationScreenViewmodel extends ChangeNotifier {
  final AuthUsecases usecases;
  RegistrationScreenViewmodel({required this.usecases});

  String _email = '';
  String _password = '';
  String? emailError;
  String? passwordError;
  bool isLoading = false;
  bool rememberMe = false;

  void setRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  void onEmailChanged(String value) {
    _email = value.trim();
    if (!_email.contains(RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      emailError = 'Некорректный email';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _password = value.trim();
    if (_password.length < 6) {
      passwordError = 'Минимум 6 символов';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (emailError != null ||
        passwordError != null ||
        _email.isEmpty ||
        _password.isEmpty) {
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    final success = await usecases.register(_email, _password, rememberMe);
    if (success) {
      context.router.pushPath('/boards');
    } else {
      emailError = 'Ошибка регистрации';
    }
    isLoading = false;
    notifyListeners();
  }
}
