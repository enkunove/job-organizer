import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/utils/priority_embedders.dart';
import 'package:test_task/core/utils/status_embedders.dart';

import '../../../domain/entities/task_enums.dart';
import '../../viewmodels/tasks_screen_viewmodel.dart';

void showAddTaskSheet(BuildContext context, TasksScreenViewmodel vm) {
  final titleController = TextEditingController();
  final commentController = TextEditingController();

  TaskPriority? selectedPriority = vm.selectedPriority;
  TaskStatus? selectedStatus = vm.selectedStatus;
  DateTime? selectedDueDate;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: StatefulBuilder(
        builder: (context, setState) => Wrap(
          runSpacing: 12,
          children: [
            Text(
              'Новая задача',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Комментарий'),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<TaskPriority>(
                    decoration: const InputDecoration(labelText: 'Приоритет'),
                    value: selectedPriority,
                    items: TaskPriority.values
                        .map((p) => DropdownMenuItem(
                      value: p,
                      child: Text(priorityLabel(p)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<TaskStatus>(
                    decoration: const InputDecoration(labelText: 'Статус'),
                    value: selectedStatus,
                    items: TaskStatus.values
                        .where((s) => s != TaskStatus.canceled)
                        .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(statusLabel(s)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDueDate != null
                        ? 'Дата завершения: ${selectedDueDate!.day}.${selectedDueDate!.month}.${selectedDueDate!.year}'
                        : 'Дата завершения не выбрана',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDueDate = picked;
                      });
                    }
                  },
                  child: const Text('Выбрать дату'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    final newTitle = titleController.text.trim();
                    final newComment = commentController.text.trim();

                    if (newTitle.isEmpty) {
                      return;
                    }

                    vm.createTask(
                      context: context,
                      title: newTitle,
                      comment: newComment,
                      priority: selectedPriority,
                      status: selectedStatus,
                      toDo: selectedDueDate,
                    );

                    context.router.pushPath("/boards/${vm.boardId}");

                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Создать'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
