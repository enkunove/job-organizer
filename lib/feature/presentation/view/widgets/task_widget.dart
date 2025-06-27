import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/feature/domain/entities/task_enums.dart';

import '../../../domain/entities/task.dart';
import 'task_edit_dialog.dart'; // Импортируй свой диалог редактирования

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  Color _getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (task.status) {
      case TaskStatus.pending:
        return Colors.red;
      case TaskStatus.inProgress:
        return Colors.yellow;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.canceled:
        return theme.colorScheme.error;
    }
  }

  Color _getPriorityColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.amber;
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.none:
        return theme.disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(context);
    final priorityColor = _getPriorityColor(context);

    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => TaskEditDialog(task: task),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        shadowColor: statusColor.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: statusColor, width: 5)),
            borderRadius: BorderRadius.circular(14),
            color: theme.colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    "Приоритет: ${task.priority.name}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: priorityColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              if (task.comment != null && task.comment!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.comment!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: theme.disabledColor),
                  const SizedBox(width: 4),
                  Text(
                    'Создано: ${DateFormat.yMMMd().format(task.changed)}',
                    style: theme.textTheme.labelSmall,
                  ),
                  if (task.toDo != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.schedule, size: 16, color: theme.disabledColor),
                    const SizedBox(width: 4),
                    Text(
                      'Сделать до: ${DateFormat.yMMMd().format(task.toDo!)}',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.status.name.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
