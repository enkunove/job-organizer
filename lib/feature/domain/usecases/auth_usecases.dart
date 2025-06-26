import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';

class AuthUsecases{

  final UserRepository repository;

  AuthUsecases({required this.repository});


  Future<bool> login(String email, String password) async {
    final UserCredential? userCredential = await repository.login(email, password);
    return userCredential != null ?  true : false;
  }

  Future<bool> register(String email, String password) async {
    final UserCredential? userCredential = await repository.register(email, password);
    return userCredential != null ?  true : false;
  }
}