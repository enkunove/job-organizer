import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/feature/domain/entities/board.dart';

class BoardHeaderWidget extends StatelessWidget {
  final Board board;
  const BoardHeaderWidget({super.key, required this.board});

  Color _parseColor(String hex) {
    final normalized = hex.length == 6 ? 'FF$hex' : hex;
    return Color(int.parse(normalized, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _parseColor(board.colorHex);
    final formattedDate = DateFormat(
      'd MMM yyyy, HH:mm',
    ).format(board.lastUpdate.toLocal());

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 3),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    board.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Редактировать доску',
                  onPressed: (){},
                ),
              ],
            ),
            if (board.description != null &&
                board.description!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  board.description!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Обновлено: $formattedDate',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
