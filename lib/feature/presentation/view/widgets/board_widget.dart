import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/feature/domain/entities/board.dart';

class BoardWidget extends StatefulWidget {
  final Board board;

  const BoardWidget({
    super.key,
    required this.board,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final board = widget.board;
    final backgroundColor = Color(int.parse(board.colorHex, radix: 16)).withOpacity(1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: _pressed ? 8 : 2,
        end: _pressed ? 8 : 2,
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      builder: (context, elevation, child) {
        return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: ()=>context.router.pushPath("/boards/${board.id}"),
            onHighlightChanged: (value) {
              setState(() => _pressed = value);
            },
            splashColor: backgroundColor.withOpacity(0.1),
            highlightColor: backgroundColor.withOpacity(0.05),
            child: AnimatedContainer(
              alignment: Alignment.center, // <<< ВОТ ЭТО
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              transform: Matrix4.identity()..scale(_pressed ? 0.97 : 1.0),
              transformAlignment: Alignment.center, // <<< И ВОТ ЭТО
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.15),
                    blurRadius: elevation,
                    spreadRadius: 1,
                    offset: Offset(0, elevation / 2),
                  ),
                ],
                border: Border.all(
                  color: backgroundColor,
                  width: _pressed ? 1.5 : 2.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          board.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (board.description != null && board.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      board.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Создано: ${DateFormat.yMMMd().format(board.createdAt)}',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),

        );
      },
    );
  }
}
