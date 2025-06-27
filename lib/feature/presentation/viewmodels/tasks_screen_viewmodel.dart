import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';

import '../../domain/entities/board.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_enums.dart';
import '../../domain/usecases/tasks_usecases.dart';

class TasksScreenViewmodel extends ChangeNotifier {
  final TasksUsecases tasksUsecases;
  final BoardsUsecases boardsUsecases;

  late final String boardId;
  late Future<List<Task>> allTasks;

  TaskPriority? _selectedPriority;
  TaskStatus? _selectedStatus;
  TaskSortOption? _selectedSortOption;

  late final Future<Board> board;

  TasksScreenViewmodel({required this.tasksUsecases, required this.boardsUsecases});

  void init(String id) {
    boardId = id;
    allTasks = getTasksForBoard();
    board = boardsUsecases.getBoardById(boardId);
  }

  Future<List<Task>> getTasksForBoard() async {
    return await tasksUsecases.getTasksForBoardByBoardId(boardId);
  }

  TaskPriority? get selectedPriority => _selectedPriority;
  TaskStatus? get selectedStatus => _selectedStatus;
  TaskSortOption? get selectedSortOption => _selectedSortOption;

  void setPriority(TaskPriority? priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  void setStatus(TaskStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void setSortOption(TaskSortOption? option) {
    _selectedSortOption = option;
    notifyListeners();
  }

  Future<List<Task>> get filteredTasks async {
    final tasks = await allTasks;
    final filtered = tasks.where((task) {
      final matchesPriority = _selectedPriority == null || task.priority == _selectedPriority;
      final matchesStatus = _selectedStatus == null || task.status == _selectedStatus;
      return matchesPriority && matchesStatus;
    }).toList();
    if (_selectedSortOption == null) return filtered;
    filtered.sort((a, b) {
      switch (_selectedSortOption!) {
        case TaskSortOption.updatedDate:
          return b.changed.compareTo(a.changed);
        case TaskSortOption.priority:
          return a.priority.index.compareTo(b.priority.index);
        case TaskSortOption.deadline:
          final aDeadline = a.toDo ?? DateTime(2100);
          final bDeadline = b.toDo ?? DateTime(2100);
          return aDeadline.compareTo(bDeadline);
      }
    });

    return filtered;
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
    await tasksUsecases.createTask(
      boardId: boardId,
      title: title,
      comment: comment,
      priority: priority,
      status: status,
      toDo: toDo,
    );
    notifyListeners();
  }
}