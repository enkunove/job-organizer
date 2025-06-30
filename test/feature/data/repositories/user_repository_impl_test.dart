import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/feature/data/datasources/local/settings_datasource.dart';
import 'package:test_task/feature/data/datasources/remote/user_datasource.dart';
import 'package:test_task/feature/data/repositories/user_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockUserDatasource extends Mock implements UserDatasource {}
class MockSettingsDatasource extends Mock implements SettingsDatasource {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late UserDatasource userDatasource;
  late SettingsDatasource settingsDatasource;
  late UserRepositoryImpl repository;

  setUp(() {
    userDatasource = MockUserDatasource();
    settingsDatasource = MockSettingsDatasource();
    repository = UserRepositoryImpl(
      userDatasource: userDatasource,
      settingsDatasource: settingsDatasource,
    );
  });

  test('register returns UserCredential', () async {
    final credential = MockUserCredential();
    when(() => userDatasource.register('test@test.com', '123456'))
        .thenAnswer((_) async => credential);
    final result = await repository.register('test@test.com', '123456');
    expect(result, credential);
  });

  test('login returns UserCredential', () async {
    final credential = MockUserCredential();
    when(() => userDatasource.login('test@test.com', '123456'))
        .thenAnswer((_) async => credential);
    final result = await repository.login('test@test.com', '123456');
    expect(result, credential);
  });

  test('setRememberMe calls datasource', () async {
    when(() => settingsDatasource.setRememberMe(true)).thenAnswer((_) async {});
    await repository.setRememberMe(true);
    verify(() => settingsDatasource.setRememberMe(true)).called(1);
  });

  test('getRememberMe returns value', () async {
    when(() => settingsDatasource.getRememberMe()).thenAnswer((_) async => true);
    final result = await repository.getRememberMe();
    expect(result, true);
  });

  test('setPersistence calls datasource', () async {
    when(() => userDatasource.setPersistence(false)).thenAnswer((_) async {});
    await repository.setPersistence(false);
    verify(() => userDatasource.setPersistence(false)).called(1);
  });

  test('getCurrentUser returns User', () async {
    final user = MockUser();
    when(() => userDatasource.getCurrentUser()).thenAnswer((_) async => user);
    final result = await repository.getCurrentUser();
    expect(result, user);
  });
}
