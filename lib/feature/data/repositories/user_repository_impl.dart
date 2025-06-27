import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/data/datasources/local/settings_datasource.dart';
import 'package:test_task/feature/data/datasources/remote/user_datasource.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserDatasource userDatasource;
  final SettingsDatasource settingsDatasource;

  const UserRepositoryImpl({required this.userDatasource, required this.settingsDatasource});

  @override
  Future<UserCredential?> register(String email, String password) async {
    return await userDatasource.register(email, password);
  }
  @override
  Future<UserCredential?> login(String email, String password) async {
    return await userDatasource.login(email, password);
  }

  @override
  Future<void> setRememberMe(bool value) async {
    await settingsDatasource.setRememberMe(value);
  }

  @override
  Future<bool> getRememberMe() async {
    return await settingsDatasource.getRememberMe();
  }

  @override
  Future<void> setPersistence(bool rememberMe) async  {
    return await userDatasource.setPersistence(rememberMe);
  }

  @override
  Future<User?> getCurrentUser() async{
    return await userDatasource.getCurrentUser();
  }

}