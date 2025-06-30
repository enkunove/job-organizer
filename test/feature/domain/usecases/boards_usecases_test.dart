import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:test_task/feature/domain/entities/board.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';

class MockBoardsRepository extends Mock implements BoardsRepository {}

void main() {
  late MockBoardsRepository repository;
  const uid = 'test-uid';

  Board testBoard() => Board(
    ownerId: uid,
    title: 'Test',
    description: 'Desc',
    colorHex: '#fff',
    createdAt: DateTime(2024),
    lastUpdate: DateTime(2024),
    isArchived: false,
  );

  setUp(() {
    repository = MockBoardsRepository();
    registerFallbackValue(testBoard());
  });


  test('createBoard throws when user is null', () async {
    final auth = MockFirebaseAuth();
    final usecases = BoardsUsecases(repository: repository, firebaseAuth: auth);
    await auth.signOut();
    expect(
          () => usecases.createBoard(title: 't', description: 'd', colorHex: '#000'),
      throwsA(isA<Exception>()),
    );
  });


  test('getBoards throws when user is null', () async {
    final auth = MockFirebaseAuth();
    final usecases = BoardsUsecases(repository: repository, firebaseAuth: auth);
    await auth.signOut();
    expect(() => usecases.getBoards(), throwsA(isA<Exception>()));
  });
}
