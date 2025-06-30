import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:test_task/feature/domain/usecases/auth_usecases.dart';

// Моки
class MockUserRepository extends Mock implements UserRepository {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockUserRepository mockRepository;
  late AuthUsecases usecases;

  setUp(() {
    mockRepository = MockUserRepository();
    usecases = AuthUsecases(repository: mockRepository);
  });

  group('AuthUsecases', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const rememberMe = true;

    test('login returns true when UserCredential is not null', () async {
      final mockCredential = MockUserCredential();

      when(() => mockRepository.setPersistence(rememberMe))
          .thenAnswer((_) async {});
      when(() => mockRepository.login(testEmail, testPassword))
          .thenAnswer((_) async => mockCredential);
      when(() => mockRepository.setRememberMe(rememberMe))
          .thenAnswer((_) async {});

      final result = await usecases.login(testEmail, testPassword, rememberMe);

      expect(result, true);

      verify(() => mockRepository.setPersistence(rememberMe)).called(1);
      verify(() => mockRepository.login(testEmail, testPassword)).called(1);
      verify(() => mockRepository.setRememberMe(rememberMe)).called(1);
    });

    test('login returns false when UserCredential is null', () async {
      when(() => mockRepository.setPersistence(rememberMe))
          .thenAnswer((_) async {});
      when(() => mockRepository.login(testEmail, testPassword))
          .thenAnswer((_) async => null);
      when(() => mockRepository.setRememberMe(rememberMe))
          .thenAnswer((_) async {});

      final result = await usecases.login(testEmail, testPassword, rememberMe);

      expect(result, false);
    });

    test('register returns true when UserCredential is not null', () async {
      final mockCredential = MockUserCredential();

      when(() => mockRepository.setPersistence(rememberMe))
          .thenAnswer((_) async {});
      when(() => mockRepository.register(testEmail, testPassword))
          .thenAnswer((_) async => mockCredential);
      when(() => mockRepository.setRememberMe(rememberMe))
          .thenAnswer((_) async {});

      final result =
      await usecases.register(testEmail, testPassword, rememberMe);

      expect(result, true);
    });

    test('register returns false when UserCredential is null', () async {
      when(() => mockRepository.setPersistence(rememberMe))
          .thenAnswer((_) async {});
      when(() => mockRepository.register(testEmail, testPassword))
          .thenAnswer((_) async => null);
      when(() => mockRepository.setRememberMe(rememberMe))
          .thenAnswer((_) async {});

      final result =
      await usecases.register(testEmail, testPassword, rememberMe);

      expect(result, false);
    });

    test('getRememberMe returns value from repository', () async {
      when(() => mockRepository.getRememberMe())
          .thenAnswer((_) async => true);

      final result = await usecases.getRememberMe();

      expect(result, true);
      verify(() => mockRepository.getRememberMe()).called(1);
    });

    test('getCurrentUser returns user from repository', () async {
      final mockUser = MockUser();

      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => mockUser);

      final result = await usecases.getCurrentUser();

      expect(result, mockUser);
      verify(() => mockRepository.getCurrentUser()).called(1);
    });
  });
}
