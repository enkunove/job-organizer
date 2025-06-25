import 'package:test_task/feature/domain/entities/task_enums.dart';

class Task {
  final String title;
  final String? comment;
  final DateTime created;
  final DateTime? toDo;
  final TaskStatus? status;
  final TaskPriority priority;

  Task({
    required this.title,
    required this.comment,
    required this.status,
    required this.created,
    required this.toDo,
    required this.priority
  });
}