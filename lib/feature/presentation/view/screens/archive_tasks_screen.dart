import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/service_locator.dart';
import 'package:test_task/feature/domain/entities/task_enums.dart';
import 'package:test_task/feature/domain/usecases/tasks_usecases.dart';

import '../../../domain/entities/task.dart';
import '../widgets/task_widget.dart';

@RoutePage()
class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Удаленные задачи")),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: InjectionContainer.sl<TasksUsecases>().getUserTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }
                final tasks =
                    snapshot.data!
                        .where((e) => e.status == TaskStatus.canceled)
                        .toList();
                tasks.sort((a, b) => a.changed.compareTo(b.changed));
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'Задач пока нет',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  );
                }

                tasks.forEach((e) => print(e.status.name));

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
    );
  }
}
