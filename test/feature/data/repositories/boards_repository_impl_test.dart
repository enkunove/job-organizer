import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/feature/data/datasources/remote/boards_datasource.dart';
import 'package:test_task/feature/data/models/board_model.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/data/repositories/boards_repository_impl.dart';

class MockBoardsDatasource extends Mock implements BoardsDatasource {}

void main() {
  late MockBoardsDatasource mockDatasource;
  late BoardsRepository repository;

  final boardMap = {
    'id': '1',
    'ownerId': 'owner',
    'title': 'Board',
    'colorHex': '#fff',
    'description': 'desc',
    'createdAt': DateTime(2024).toIso8601String(),
    'lastUpdate': DateTime(2024).toIso8601String(),
    'isArchived': false,
  };

  final boardModel = BoardModel.fromMap(boardMap);

  setUp(() {
    mockDatasource = MockBoardsDatasource();
    repository = BoardsRepositoryImpl(datasource: mockDatasource);
  });

  test('createBoard calls datasource', () async {
    when(() => mockDatasource.createBoard(any())).thenAnswer((_) async {});
    await repository.createBoard(boardModel);
    verify(() => mockDatasource.createBoard(any())).called(1);
  });

  test('updateBoard calls datasource', () async {
    when(() => mockDatasource.updateBoard(any())).thenAnswer((_) async {});
    await repository.updateBoard(boardModel);
    verify(() => mockDatasource.updateBoard(any())).called(1);
  });

  test('getBoardsByOwner returns list of BoardModel', () async {
    when(() => mockDatasource.getBoardsByOwner('owner')).thenAnswer((_) async => [boardMap]);
    final result = await repository.getBoardsByOwner('owner');
    expect(result.first.id, '1');
  });

  test('getBoardById returns BoardModel', () async {
    when(() => mockDatasource.getBoardById('1')).thenAnswer((_) async => boardMap);
    final result = await repository.getBoardById('1');
    expect(result.id, '1');
  });
}
