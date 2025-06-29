import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:test_task/core/service_locator.dart';
import 'package:test_task/feature/domain/usecases/boards_usecases.dart';
import '../../../domain/entities/board.dart';

class BoardEditDialog extends StatefulWidget {
  final Board board;

  const BoardEditDialog({super.key, required this.board});

  @override
  State<BoardEditDialog> createState() => _BoardEditDialogState();
}

class _BoardEditDialogState extends State<BoardEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _colorHex;
  late bool _isArchived;

  final BoardsUsecases _usecases = InjectionContainer.sl<BoardsUsecases>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.board.title);
    _descriptionController = TextEditingController(text: widget.board.description ?? '');
    _colorHex = widget.board.colorHex;
    _isArchived = widget.board.isArchived;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickColor() {
    Color currentColor = Color(int.parse(_colorHex, radix: 16));

    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = currentColor;

        return AlertDialog(
          title: const Text('Выберите цвет'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) => tempColor = color,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Выбрать'),
              onPressed: () {
                setState(() {
                  _colorHex = tempColor.value.toRadixString(16).padLeft(8, '0').toUpperCase();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveBoard() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) return;

    final updated = widget.board.copyWith(
      title: title,
      description: description,
      colorHex: _colorHex,
      isArchived: _isArchived,
      lastUpdate: DateTime.now(),
    );

    await _usecases.updateBoard(updated);
    if (mounted) {
      Navigator.of(context).pop();
      context.router.pushPath("/boards/${widget.board.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = Color(int.parse(_colorHex, radix: 16));

    return AlertDialog(
      title: const Text('Редактировать доску'),
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
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickColor,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: currentColor, width: 2),
                  color: currentColor.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: currentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Выбрать цвет'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: _isArchived,
                  onChanged: (val) => setState(() => _isArchived = val ?? false),
                ),
                const Text('Архивировать'),
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
          onPressed: _saveBoard,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
