import 'package:test_task/feature/domain/entities/board.dart';
import 'package:test_task/feature/domain/entities/notification.dart';
import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/domain/repositories/notifications_repository.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/task_enums.dart';
import '../repositories/tasks_repository.dart';

class TasksUsecases {
  final TasksRepository tasksRepository;
  final UserRepository userRepository;
  final BoardsRepository boardsRepository;
  final NotificationsRepository notificationsRepository;
  TasksUsecases({required this.tasksRepository, required this.userRepository, required this.notificationsRepository, required this.boardsRepository});

  Future<List<Task>> getTasksForBoardByBoardId(String boardId) async {
    final rawList = await tasksRepository.getTasksForBoardByBoardId(boardId);
    return rawList.where((e) => e.status != TaskStatus.canceled).toList();
  }

  Future<List<Task>> getUserTasks() async {
    String userId = (await userRepository.getCurrentUser())!.uid;
    final rawList = await tasksRepository.getUserTasks(userId);
    return rawList;
  }

  Future<void> deleteTask(Task task) async {
    await tasksRepository.updateTask(task.copyWith(status: TaskStatus.canceled));
    final Board board = await boardsRepository.getBoardById(task.boardId);
    return await boardsRepository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }
  Future<void> updateTask(Task task) async {
    await tasksRepository.updateTask(task.copyWith(changed: DateTime.now()));
    if (task.toDo != null){
      notificationsRepository.scheduleNotification(Notification(id: 0, title: task.title, body: "Время на задачу выходит. Остался 1 день", scheduledTime: task.toDo!.subtract(Duration(days: 1))));
    }
    final Board board = await boardsRepository.getBoardById(task.boardId);
    return await boardsRepository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }

  Future<void> createTask({
    required String boardId,
    required String title,
    String? comment,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? toDo,
  }) async {
    final User? user = await userRepository.getCurrentUser();
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      ownerId: user!.uid,
      boardId: boardId,
      title: title,
      comment: comment,
      changed: DateTime.now(),
      toDo: toDo,
      priority: priority ?? TaskPriority.none,
      status: status ?? TaskStatus.pending,
    );
    await tasksRepository.createTask(newTask);
    if (newTask.toDo != null){
      notificationsRepository.scheduleNotification(Notification(id: 0, title: newTask.title, body: "Время на задачу выходит. Остался 1 день", scheduledTime: newTask.toDo!.subtract(Duration(days: 1))));
    }
    final Board board = await boardsRepository.getBoardById(newTask.boardId);
    return await boardsRepository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }

  Future<void> requestPermissions() => notificationsRepository.requestPermissions();
}
