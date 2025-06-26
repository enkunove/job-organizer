import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/data/datasources/remote/user_datasource.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserDatasource datasource;

  const UserRepositoryImpl({required this.datasource});

  @override
  Future<UserCredential?> register(String email, String password) async {
    return await datasource.register(email, password);
  }
  @override
  Future<UserCredential?> login(String email, String password) async {
    return await datasource.login(email, password);
  }

}