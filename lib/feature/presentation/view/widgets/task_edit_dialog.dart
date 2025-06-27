import 'package:flutter/material.dart';
import 'package:test_task/core/service_locator.dart';
import 'package:test_task/feature/domain/usecases/tasks_usecases.dart';
import '../../../domain/entities/task_enums.dart';
import '../../../domain/entities/task.dart';

class TaskEditDialog extends StatefulWidget {
  final Task task;

  const TaskEditDialog({super.key, required this.task});

  @override
  State<TaskEditDialog> createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  late TaskStatus _status;
  late TaskPriority _priority;

  final TasksUsecases usecases = InjectionContainer.sl<TasksUsecases>();

  final List<TaskStatus> _availableStatuses = [
    TaskStatus.pending,
    TaskStatus.inProgress,
    TaskStatus.completed,
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.comment ?? '');
    _selectedDate = widget.task.toDo;
    _status = widget.task.status;
    _priority = widget.task.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _statusLabel(TaskStatus status) {
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

  String _priorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Низкий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.high:
        return 'Высокий';
      case TaskPriority.none:
        return 'Без приоритета';
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _deleteTask() {
    usecases.deleteTask(widget.task.id!);
    Navigator.pop(context);
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    final comment = _descriptionController.text.trim();

    if (title.isEmpty) return;

    usecases.updateTask(
      widget.task.copyWith(
        title: title,
        comment: comment,
        toDo: _selectedDate,
        status: _status,
        priority: _priority,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 8, 0),
      title: Row(
        children: [
          const Expanded(child: Text('Редактировать задачу')),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            tooltip: 'Удалить задачу',
            onPressed: _deleteTask,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? 'Дата: ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                        : 'Дата не выбрана',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Выбрать дату'),
                ),
                if (_selectedDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _selectedDate = null),
                  )
              ],
            ),
            const SizedBox(height: 20),

            /// Статус
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Статус: ${_statusLabel(_status)}'),
                const SizedBox(height: 6),
                Slider(
                  value: _availableStatuses.indexOf(_status).toDouble(),
                  min: 0,
                  max: (_availableStatuses.length - 1).toDouble(),
                  divisions: _availableStatuses.length - 1,
                  label: _statusLabel(_status),
                  onChanged: (value) {
                    setState(() {
                      _status = _availableStatuses[value.round()];
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _availableStatuses
                      .map((s) => Text(_statusLabel(s), style: const TextStyle(fontSize: 12)))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Приоритет
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Приоритет: ${_priorityLabel(_priority)}'),
                const SizedBox(height: 6),
                Slider(
                  value: _priority.index.toDouble(),
                  min: 0,
                  max: TaskPriority.values.length - 1.toDouble(),
                  divisions: TaskPriority.values.length - 1,
                  activeColor: Colors.red,
                  label: _priorityLabel(_priority),
                  onChanged: (value) {
                    setState(() {
                      _priority = TaskPriority.values[value.round()];
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: TaskPriority.values
                      .map((p) => Text(_priorityLabel(p), style: const TextStyle(fontSize: 12)))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveTask,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
