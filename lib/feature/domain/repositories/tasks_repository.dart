import '../entities/task.dart';

abstract class TasksRepository{
  Future<List<Task>> getTasksForBoardByBoardId(String boardId);
  Future<List<Task>> getUserTasks(String userId);
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
}