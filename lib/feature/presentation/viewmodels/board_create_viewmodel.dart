import 'package:flutter/material.dart';

import '../../domain/usecases/boards_usecases.dart';

class BoardCreateViewModel extends ChangeNotifier {
  final BoardsUsecases usecases;

  BoardCreateViewModel({required this.usecases});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Color selectedColor = Colors.blue;


  String? titleError;
  bool isLoading = false;

  bool validate() {
    titleError = null;

    if (titleController.text.trim().isEmpty) {
      titleError = 'Название не может быть пустым';
    }
    notifyListeners();

    return titleError == null;
  }

  Future<bool> createBoard() async {
    if (!validate()) return false;
    isLoading = true;
    notifyListeners();

    try {
      await usecases.createBoard(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        colorHex: selectedColor.value.toRadixString(16).toUpperCase().padLeft(8, '0'),
      );
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void setColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
