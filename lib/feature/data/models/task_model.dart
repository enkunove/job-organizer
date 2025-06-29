import 'package:test_task/feature/domain/entities/task.dart';
import 'package:test_task/feature/domain/entities/task_enums.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.ownerId,
    required super.boardId,
    required super.title,
    super.comment,
    required super.changed,
    super.toDo,
    super.status,
    super.priority,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      boardId: map['boardId'] as String,
      title: map['title'] as String,
      comment: map['comment'] as String?,
      changed: DateTime.parse(map['changed'] as String),
      toDo: map['toDo'] != null ? DateTime.parse(map['toDo']) : null,
      status: TaskStatus.values.byName(map['status'] ?? 'pending'),
      priority: TaskPriority.values.byName(map['priority'] ?? 'none'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'ownerId' : ownerId,
      'boardId': boardId,
      'title': title,
      'comment': comment,
      'changed': changed.toIso8601String(),
      'toDo': toDo?.toIso8601String(),
      'status': status.name,
      'priority': priority.name,
    };
  }
}
