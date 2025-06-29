import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/core/service_locator.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';
import 'dart:ui';
import '../../../../core/routing/app_routing.gr.dart';
import '../../../domain/entities/board.dart';
import '../widgets/board_widget.dart';
import '../widgets/info_dialog.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BoardsUsecases usecases = InjectionContainer.sl<BoardsUsecases>();
  List<Board> _boards = [];

  Future<void> _checkDialog() async {
    if (await shouldShowDialog()) {
      Future.delayed(const Duration(seconds: 1), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showBetaDialog(context);
        });
      });
    }
  }
  @override
  void initState() {
    _checkDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои доски задач'),
        actions: [
          IconButton(
            onPressed: () => context.router.pushPath("/archive/boards"),
            icon: const Icon(Icons.archive_outlined),
          ),
          IconButton(
            onPressed: () => context.router.pushPath("/settings"),
            icon: const Icon(Icons.settings),
          ),
        ],
        automaticallyImplyLeading: false,
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
          _boards.sort((a, b) => a.lastUpdate.compareTo(b.lastUpdate));
          final data = _boards.reversed.where((e) => !e.isArchived).toList();

          final screenWidth = MediaQuery.of(context).size.width;
          final isSmall = screenWidth < 500;
          final crossAxisCount = isSmall ? 1 : 2;
          final padding = 16.0;
          final spacing = 16.0;

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: ListView.builder(
                        itemCount: (data.length / crossAxisCount).ceil(),
                        itemBuilder: (context, rowIndex) {
                          final startIndex = rowIndex * crossAxisCount;
                          final endIndex = (startIndex + crossAxisCount).clamp(
                            0,
                            data.length,
                          );
                          final rowItems = data.sublist(startIndex, endIndex);

                          return Padding(
                            padding: EdgeInsets.only(bottom: spacing),
                            child: Row(
                              children: List.generate(rowItems.length, (i) {
                                final board = rowItems[i];
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right:
                                          i == rowItems.length - 1
                                              ? 0
                                              : spacing,
                                    ),
                                    child: BoardWidget(board: board),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fabTutorialHero',
        onPressed: () {
          context.router.push(const BoardCreateRoute());
        },
        label: const Text('Новая доска задач'),

        icon: const Icon(Icons.add),
      ),
    );
  }
}
