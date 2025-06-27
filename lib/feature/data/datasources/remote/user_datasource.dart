import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserDatasource {
  UserDatasource();

  Future<UserCredential?> register(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      final user = FirebaseAuth.instance.currentUser;
      print(user);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message ?? 'FirebaseAuthException registr');
      return null;
    }
  }

  Future<UserCredential?> login(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message ?? 'FirebaseAuthException login');
      return null;
    }
  }

  Future<void> setPersistence(bool rememberMe) async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(
        rememberMe ? Persistence.LOCAL : Persistence.SESSION,
      );
    }
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}


