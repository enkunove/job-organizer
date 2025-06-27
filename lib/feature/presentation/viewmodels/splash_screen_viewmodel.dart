import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../firebase_options.dart';
import '../../domain/usecases/auth_usecases.dart';

class AppState extends ChangeNotifier {
  final AuthUsecases usecases;

  AppState({required this.usecases});
  bool _isInitialized = false;
  bool _isLoggedIn = false;

  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    final rememberMe = await usecases.getRememberMe();

    final currentUser = await usecases.getCurrentUser();
    _isLoggedIn = rememberMe && currentUser != null;

    _isInitialized = true;
    notifyListeners();
  }
}
