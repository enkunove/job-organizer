import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../firebase_options.dart';

class AppState extends ChangeNotifier {
  bool _isInitialized = false;
  bool _isLoggedIn = false;

  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Future.delayed(const Duration(seconds: 2));
    _isLoggedIn = false;
    _isInitialized = true;
    notifyListeners();
  }
}
