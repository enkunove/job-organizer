import 'package:test_task/feature/domain/entities/task_enums.dart';

class Task {
  final String id;
  final String boardId;
  final String title;
  final String? comment;
  final DateTime created;
  final DateTime? toDo;
  final TaskStatus status;
  final TaskPriority priority;

  Task({
    required this.id,
    required this.boardId,
    required this.title,
    this.comment,
    required this.created,
    this.toDo,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.none,
  });
}