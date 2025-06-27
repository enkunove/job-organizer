import 'package:test_task/feature/domain/entities/task_enums.dart';

class Task {
  final String? id;
  final String boardId;
  final String title;
  final String? comment;
  final DateTime changed;
  final DateTime? toDo;
  final TaskStatus status;
  final TaskPriority priority;

  Task({
    this.id,
    required this.boardId,
    required this.title,
    this.comment,
    required this.changed,
    this.toDo,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.none,
  });

  Task copyWith({
    String? id,
    String? title,
    String? comment,
    DateTime? changed,
    DateTime? toDo,
    TaskStatus? status,
    TaskPriority? priority,
    String? boardId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      changed: changed ?? this.changed,
      toDo: toDo ?? this.toDo,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      boardId: boardId ?? this.boardId,
    );
  }

}