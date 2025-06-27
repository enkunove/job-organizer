import 'package:flutter/material.dart';
import 'package:test_task/feature/presentation/viewmodels/tasks_screen_viewmodel.dart';

import '../../../../core/utils/priority_embedders.dart';
import '../../../../core/utils/status_embedders.dart';
import '../../../domain/entities/task_enums.dart';

String sortOptionLabel(TaskSortOption option) {
  switch (option) {
    case TaskSortOption.updatedDate:
      return 'Дата изменения';
    case TaskSortOption.priority:
      return 'Приоритет';
    case TaskSortOption.deadline:
      return 'Срок';
  }
}

class TaskFilters extends StatelessWidget {
  final TasksScreenViewmodel vm;
  const TaskFilters({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<TaskPriority?>(
                  isExpanded: true,
                  value: vm.selectedPriority,
                  hint: const Text('Приоритет'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Все приоритеты'),
                    ),
                    ...TaskPriority.values.map(
                          (priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priorityLabel(priority)),
                      ),
                    ),
                  ],
                  onChanged: vm.setPriority,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<TaskStatus?>(
                  isExpanded: true,
                  value: vm.selectedStatus,
                  hint: const Text('Статус'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Все статусы'),
                    ),
                    ...TaskStatus.values
                        .where((status) => status != TaskStatus.canceled)
                        .map(
                          (status) => DropdownMenuItem(
                        value: status,
                        child: Text(statusLabel(status)),
                      ),
                    ),
                  ],
                  onChanged: vm.setStatus,
                ),
              ),
            ],
          ),
          Center(
            child: DropdownButton<TaskSortOption>(
              isExpanded: true,
              value: vm.selectedSortOption,
              hint: const Text('Сортировать по'),
              items: TaskSortOption.values
                  .map(
                    (option) => DropdownMenuItem(
                  value: option,
                  child: Text(sortOptionLabel(option)),
                ),
              )
                  .toList(),
              onChanged: vm.setSortOption,
            ),
          )
        ],
      ),
    );
  }
}
