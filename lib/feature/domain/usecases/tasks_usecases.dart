import 'package:test_task/feature/domain/entities/board.dart';
import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';
import 'package:test_task/feature/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/task_enums.dart';
import '../repositories/tasks_repository.dart';

class TasksUsecases {
  final TasksRepository tasksRepository;
  final UserRepository userRepository;
  final BoardsRepository boardsRepository;
  TasksUsecases({required this.tasksRepository, required this.userRepository, required this.boardsRepository});

  Future<List<Task>> getTasksForBoardByBoardId(String boardId) async {
    final rawList = await tasksRepository.getTasksForBoardByBoardId(boardId);
    return rawList.where((e) => e.status != TaskStatus.canceled).toList();
  }
  Future<void> deleteTask(Task task) async {
    await tasksRepository.updateTask(task.copyWith(status: TaskStatus.canceled));
    final Board board = await boardsRepository.getBoardById(task.boardId);
    return await boardsRepository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }
  Future<void> updateTask(Task task) async {
    await tasksRepository.updateTask(task.copyWith(changed: DateTime.now()));
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
    final Board board = await boardsRepository.getBoardById(newTask.boardId);
    return await boardsRepository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }
}
