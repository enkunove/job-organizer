import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';

class AuthUsecases{

  final UserRepository repository;

  AuthUsecases({required this.repository});


  Future<bool> login(String email, String password, bool rememberMe) async {
    await repository.setPersistence(rememberMe);
    final UserCredential? userCredential = await repository.login(email, password);
    await repository.setRememberMe(rememberMe);
    return userCredential != null ?  true : false;
  }

  Future<bool> register(String email, String password, bool rememberMe) async {
    await repository.setPersistence(rememberMe);
    final UserCredential? userCredential = await repository.register(email, password);
    await repository.setRememberMe(rememberMe);
    return userCredential != null ?  true : false;
  }

  Future<bool> getRememberMe() async{
    return await repository.getRememberMe();
  }

  Future<User?> getCurrentUser()async {
    return await repository.getCurrentUser();
  }
}