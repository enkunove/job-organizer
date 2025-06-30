import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/feature/data/datasources/remote/tasks_datasource.dart';
import 'package:test_task/feature/data/models/task_model.dart';
import 'package:test_task/feature/data/repositories/tasks_repository_impl.dart';
import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/repositories/tasks_repository.dart';

class MockTasksDatasource extends Mock implements TasksDatasource {}

void main() {
  late TasksDatasource datasource;
  late TasksRepository repository;

  final taskMap = {
    'id': '123',
    'ownerId': 'owner',
    'boardId': 'board1',
    'title': 'Test Task',
    'changed': DateTime(2024).toIso8601String(),
    'priority': 'none',
    'status': 'pending',
    'toDo': null,
    'comment': 'test'
  };

  final taskModel = TaskModel.fromMap(taskMap);

  final task = Task(
    id: taskModel.id,
    ownerId: taskModel.ownerId,
    boardId: taskModel.boardId,
    title: taskModel.title,
    changed: taskModel.changed,
    priority: taskModel.priority,
    status: taskModel.status,
    toDo: taskModel.toDo,
    comment: taskModel.comment,
  );

  setUp(() {
    datasource = MockTasksDatasource();
    repository = TasksRepositoryImpl(datasource: datasource);
  });

  test('getTasksForBoardByBoardId returns list of TaskModel', () async {
    when(() => datasource.getTasksForBoardByBoardId('board1'))
        .thenAnswer((_) async => [taskMap]);
    final result = await repository.getTasksForBoardByBoardId('board1');
    expect(result.first.id, '123');
  });

  test('createTask calls datasource with correct map', () async {
    when(() => datasource.createTask(any())).thenAnswer((_) async {});
    await repository.createTask(task);
    verify(() => datasource.createTask(any())).called(1);
  });

  test('updateTask calls datasource with correct map', () async {
    when(() => datasource.updateTask(any())).thenAnswer((_) async {});
    await repository.updateTask(task);
    verify(() => datasource.updateTask(any())).called(1);
  });

  test('getUserTasks returns list of Task', () async {
    when(() => datasource.getUserTasks('owner')).thenAnswer((_) async => [taskMap]);
    final result = await repository.getUserTasks('owner');
    expect(result.first.id, '123');
  });
}
