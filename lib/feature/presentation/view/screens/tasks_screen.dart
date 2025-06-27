import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/feature/presentation/viewmodels/tasks_screen_viewmodel.dart';
import '../../../../core/service_locator.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_enums.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/task_widget.dart';

@RoutePage()
class TasksScreen extends StatefulWidget {
  final String boardId;

  const TasksScreen({super.key, @PathParam('boardId') required this.boardId});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  Widget _buildFilters(TasksScreenViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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
                    child: Text(priority.name),
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
                ...TaskStatus.values.map(
                      (status) => DropdownMenuItem(
                    value: status,
                    child: Text(status.name),
                  ),
                ),
              ],
              onChanged: vm.setStatus,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) {
        final vm = InjectionContainer.sl<TasksScreenViewmodel>();
        vm.init(widget.boardId);
        return vm;
      },
      child: Consumer<TasksScreenViewmodel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Задачи'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: vm.refresh,
                  tooltip: 'Обновить',
                ),
                IconButton(
                  icon: const Icon(Icons.add_task),
                  onPressed: () => showAddTaskSheet(context, vm),
                  tooltip: 'Добавить задачу',
                ),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 12),
                _buildFilters(vm),
                const SizedBox(height: 12),
                Expanded(
                  child: FutureBuilder<List<Task>>(
                    future: vm.filteredTasks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Ошибка: ${snapshot.error}'));
                      }

                      final tasks = snapshot.data ?? [];

                      if (tasks.isEmpty) {
                        return Center(
                          child: Text(
                            'Задач пока нет',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return TaskWidget(task: tasks[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => showAddTaskSheet(context, vm),
              icon: const Icon(Icons.add),
              label: const Text('Новая задача'),
            ),
          );
        },
      ),
    );
  }
}
