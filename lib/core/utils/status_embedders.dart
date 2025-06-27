import 'package:flutter/material.dart';
import '../../feature/domain/entities/task.dart';
import '../../feature/domain/entities/task_enums.dart';

Color getStatusColor(Task task) {
  switch (task.status) {
    case TaskStatus.pending:
      return Colors.red;
    case TaskStatus.inProgress:
      return Colors.yellow;
    case TaskStatus.completed:
      return Colors.green;
    case TaskStatus.canceled:
      return Colors.transparent;
  }
}

String statusLabel(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return 'Ожидает';
    case TaskStatus.inProgress:
      return 'В процессе';
    case TaskStatus.completed:
      return 'Завершено';
    case TaskStatus.canceled:
      return 'Отменено';
  }
}