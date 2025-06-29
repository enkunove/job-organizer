import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/repositories/tasks_repository.dart';

import '../datasources/remote/tasks_datasource.dart';
import '../models/task_model.dart';

class TasksRepositoryImpl implements TasksRepository{

  final TasksDatasource datasource;

  TasksRepositoryImpl({required this.datasource});

  @override
  Future<List<TaskModel>> getTasksForBoardByBoardId(String boardId) async {
    final List<Map<String, dynamic>> maps = await datasource.getTasksForBoardByBoardId(boardId);
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }

  @override
  Future<void> createTask(Task task) async{
    TaskModel model = TaskModel(ownerId: task.ownerId, boardId: task.boardId, title: task.title, changed: task.changed, priority: task.priority, status: task.status, toDo: task.toDo, comment: task.comment);
    return await datasource.createTask(model.toMap());
  }

  @override
  Future<void> updateTask(Task task) async{
    TaskModel model = TaskModel(ownerId: task.ownerId, boardId: task.boardId, title: task.title, changed: task.changed, priority: task.priority, status: task.status, toDo: task.toDo, comment: task.comment, id: task.id);
    print(model.id);
    return await datasource.updateTask(model.toMap());
  }

}