import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/task_enums.dart';
import '../../domain/usecases/tasks_usecases.dart';

class TasksScreenViewmodel extends ChangeNotifier {
  final TasksUsecases usecases;

  late final String boardId;
  late Future<List<Task>> allTasks;

  TaskPriority? _selectedPriority;
  TaskStatus? _selectedStatus;

  late final String title;
  late final String comment;
  late final String status;
  late final String priority;
  late final DateTime? toDo;


  TasksScreenViewmodel({required this.usecases});

  void init(String id) {
    boardId = id;
    allTasks = getTasksForBoard();
  }

  Future<List<Task>> getTasksForBoard() async {
    return await usecases.getTasksForBoardByBoardId(boardId);
  }


  TaskPriority? get selectedPriority => _selectedPriority;
  TaskStatus? get selectedStatus => _selectedStatus;

  void setPriority(TaskPriority? priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  void setStatus(TaskStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  Future<List<Task>> get filteredTasks async {
    final tasks = await allTasks;
    return tasks.where((task) {
      final matchesPriority = _selectedPriority == null || task.priority == _selectedPriority;
      final matchesStatus = _selectedStatus == null || task.status == _selectedStatus;
      return matchesPriority && matchesStatus;
    }).toList();
  }

  void refresh() {
    allTasks = getTasksForBoard();
    notifyListeners();
  }

  Future<void> createTask({
    required String title,
    String? comment,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? toDo,
    required BuildContext context,
  }) async {
    usecases.createTask(boardId: boardId, title: title, comment: comment,priority: priority,status: status,toDo: toDo);
    notifyListeners();
    context.router.pushPath("/boards/$boardId");
  }
}
