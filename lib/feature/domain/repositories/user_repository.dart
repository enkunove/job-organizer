import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository{
  Future<UserCredential?> register(String email, String password);
  Future<UserCredential?> login(String email, String password);
  Future<bool> getRememberMe();
  Future<void> setRememberMe(bool value);
  Future<void> setPersistence(bool rememberMe);
  Future<User?> getCurrentUser();
}