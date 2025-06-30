import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_task/feature/domain/entities/board.dart';
import 'package:test_task/feature/domain/entities/notification.dart';
import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/entities/task_enums.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/domain/repositories/notifications_repository.dart';
import 'package:test_task/feature/domain/repositories/tasks_repository.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:test_task/feature/domain/usecases/tasks_usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockTasksRepo extends Mock implements TasksRepository {}
class MockUserRepo extends Mock implements UserRepository {}
class MockBoardsRepo extends Mock implements BoardsRepository {}
class MockNotifsRepo extends Mock implements NotificationsRepository {}
class MockUser extends Mock implements User {}

void main() {
  late TasksUsecases usecases;
  late MockTasksRepo tasks;
  late MockUserRepo users;
  late MockBoardsRepo boards;
  late MockNotifsRepo notifs;
  late Task sampleTask;
  const uid = '123';

  Board testBoard() => Board(
    ownerId: uid,
    title: 'Board',
    description: '',
    colorHex: '#000',
    createdAt: DateTime(2022),
    lastUpdate: DateTime(2022),
    isArchived: false,
  );

  Task task({String id = '1', TaskStatus status = TaskStatus.pending}) => Task(
    id: id,
    ownerId: uid,
    boardId: 'board1',
    title: 'Task',
    comment: 'Comment',
    changed: DateTime.now(),
    toDo: DateTime.now().add(Duration(days: 2)),
    priority: TaskPriority.medium,
    status: status,
  );

  setUp(() {
    tasks = MockTasksRepo();
    users = MockUserRepo();
    boards = MockBoardsRepo();
    notifs = MockNotifsRepo();
    usecases = TasksUsecases(
      tasksRepository: tasks,
      userRepository: users,
      boardsRepository: boards,
      notificationsRepository: notifs,
    );
    sampleTask = task();
    registerFallbackValue(sampleTask);
    registerFallbackValue(testBoard());
  });

  test('getTasksForBoardByBoardId filters canceled tasks', () async {
    when(() => tasks.getTasksForBoardByBoardId('b')).thenAnswer((_) async => [
      task(status: TaskStatus.pending),
      task(id: '2', status: TaskStatus.canceled),
    ]);
    final result = await usecases.getTasksForBoardByBoardId('b');
    expect(result.length, 1);
  });

  test('getUserTasks returns result', () async {
    final user = MockUser();
    when(() => user.uid).thenReturn(uid);
    when(() => users.getCurrentUser()).thenAnswer((_) async => user);
    when(() => tasks.getUserTasks(uid)).thenAnswer((_) async => [sampleTask]);
    final res = await usecases.getUserTasks();
    expect(res.length, 1);
  });

  test('deleteTask updates task and board', () async {
    when(() => tasks.updateTask(any())).thenAnswer((_) async {});
    when(() => boards.getBoardById('board1')).thenAnswer((_) async => testBoard());
    when(() => boards.updateBoard(any())).thenAnswer((_) async {});
    await usecases.deleteTask(sampleTask);
    verify(() => tasks.updateTask(any())).called(1);
    verify(() => boards.updateBoard(any())).called(1);
  });

  test('requestPermissions calls notifications repo', () async {
    when(() => notifs.requestPermissions()).thenAnswer((_) async {});
    await usecases.requestPermissions();
    verify(() => notifs.requestPermissions()).called(1);
  });
}
