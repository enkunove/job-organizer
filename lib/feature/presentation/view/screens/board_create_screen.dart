import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../../core/service_locator.dart';
import '../../viewmodels/board_create_viewmodel.dart';

@RoutePage()
class BoardCreateScreen extends StatelessWidget {
  const BoardCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("board create screen");
    return ChangeNotifierProvider(
      create: (_) => InjectionContainer.sl<BoardCreateViewModel>(),
      child: Consumer<BoardCreateViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Создать доску')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: vm.titleController,
                    decoration: InputDecoration(
                      labelText: 'Название',
                      errorText: vm.titleError,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: vm.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Описание (необязательно)',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          Color tempColor = vm.selectedColor;
                          return AlertDialog(
                            title: const Text('Выберите цвет'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: vm.selectedColor,
                                onColorChanged: (color) {
                                  tempColor = color;
                                },
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
                                  vm.setColor(tempColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: vm.selectedColor, width: 2),
                        color: vm.selectedColor.withOpacity(0.3),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: vm.selectedColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('Выбрать цвет'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  vm.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      final success = await vm.createBoard();
                      if (success) {
                        context.router.replacePath("/boards");
                      }
                    },
                    child: const Text('Создать'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
