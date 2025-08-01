import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/utils/priority_embedders.dart';
import 'package:test_task/core/utils/status_embedders.dart';
import 'package:test_task/feature/presentation/view/widgets/board_header_widget.dart';
import 'package:test_task/feature/presentation/view/widgets/task_filters.dart';
import 'package:test_task/feature/presentation/viewmodels/tasks_screen_viewmodel.dart';
import '../../../../core/service_locator.dart';
import '../../../domain/entities/board.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_enums.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/task_widget.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  final String boardId;

  const TasksScreen({super.key, @PathParam('boardId') required this.boardId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) {
        final vm = InjectionContainer.sl<TasksScreenViewmodel>();
        vm.init(boardId);
        return vm;
      },
      child: Consumer<TasksScreenViewmodel>(
        builder: (context, vm, _) {
          return FutureBuilder<Board>(
            future: vm.board,
            builder: (context, boardSnapshot) {
              final board = boardSnapshot.data;

              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.router.pushPath("/boards"),
                  ),
                  title: const Text('Задачи'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: vm.refresh,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    if (boardSnapshot.connectionState == ConnectionState.waiting)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: LinearProgressIndicator(),
                      )
                    else if (boardSnapshot.hasError || board == null)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Не удалось загрузить доску'),
                      )
                    else
                      IntrinsicHeight(
                        child: BoardHeaderWidget(board: board),
                      ),
                    const SizedBox(height: 12),
                    TaskFilters(vm: vm),
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
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).hintColor,
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
                floatingActionButton: (board != null && !board.isArchived)
                    ? FloatingActionButton.extended(
                  onPressed: () => showAddTaskSheet(context, vm),
                  icon: const Icon(Icons.add),
                  label: const Text('Новая задача'),
                ): null,
              );
            },
          );
        },

      ),
    );
  }
}
