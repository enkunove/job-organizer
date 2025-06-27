import '../entities/task.dart';

abstract class TasksRepository{
  Future<List<Task>> getTasksForBoardByBoardId(String boardId);
  Future<void> createTask(Task task);
}