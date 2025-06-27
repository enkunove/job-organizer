import 'package:flutter/material.dart';

import '../../feature/domain/entities/task.dart';
import '../../feature/domain/entities/task_enums.dart';

Color getPriorityColor(Task task) {
  switch (task.priority) {
    case TaskPriority.high:
      return Colors.redAccent;
    case TaskPriority.medium:
      return Colors.amber;
    case TaskPriority.low:
      return Colors.green;
    case TaskPriority.none:
      return Colors.transparent;
  }
}

String priorityLabel(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.low:
      return 'Низкий';
    case TaskPriority.medium:
      return 'Средний';
    case TaskPriority.high:
      return 'Высокий';
    case TaskPriority.none:
      return 'Нет';
  }
}