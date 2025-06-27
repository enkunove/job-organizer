import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:test_task/core/service_locator.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';

import '../../../../core/routing/app_routing.gr.dart';
import '../../../domain/entities/board.dart';
import '../widgets/board_widget.dart';
import '../widgets/theme_toggle_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Board> _boards;
  final BoardsUsecases usecases = InjectionContainer.sl<BoardsUsecases>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои доски'),
        actions: const [ThemeToggleWidget()],
      ),
      body: FutureBuilder<List<Board>>(
        future: usecases.getBoards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет досок'));
          }

          _boards = snapshot.data!;

          final screenWidth = MediaQuery.of(context).size.width;
          final isSmall = screenWidth < 500;
          final crossAxisCount = isSmall ? 1 : 2;
          final padding = 16.0;
          final spacing = 16.0;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: GridView.builder(
              itemCount: _boards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: isSmall
                    ? (screenWidth - padding * 2) / 120
                    : (screenWidth - padding * 2 - spacing) / 2 / 120,
              ),
              itemBuilder: (context, index) {
                final board = _boards[index];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: BoardWidget(
                    key: ValueKey('${board.id}_${board.createdAt}'),
                    board: board,
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const BoardCreateRoute()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

