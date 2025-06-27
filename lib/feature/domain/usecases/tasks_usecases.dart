import 'package:test_task/feature/domain/entities/task.dart';

import '../entities/task_enums.dart';
import '../repositories/tasks_repository.dart';

class TasksUsecases {
  final TasksRepository repository;
  TasksUsecases({required this.repository});

  Future<List<Task>> getTasksForBoardByBoardId(String boardId) async {
    return await repository.getTasksForBoardByBoardId(boardId);
  }

  Future<void> createTask({
    required String boardId,
    required String title,
    String? comment,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? toDo,
  }) async {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      boardId: boardId,
      title: title,
      comment: comment,
      changed: DateTime.now(),
      toDo: toDo,
      priority: priority ?? TaskPriority.none,
      status: status ?? TaskStatus.pending,
    );
    return await repository.createTask(newTask);
  }
}
