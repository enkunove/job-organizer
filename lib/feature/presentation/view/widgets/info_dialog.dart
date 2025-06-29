import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showBetaDialog(BuildContext context) async {
    bool doNotShowAgain = true;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10,),
                  Text(
                    "Спасибо за рассмотрение тестового задания!",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'MontserratAlternates'
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Text(
                    "Создавайте доски для структурированной организации задач. Стилизуйте их по своему вкусу, управляйте задачами: добавляйте, редактируйте, удаляйте, архивируйте и восстанавливайте. Удобно фильтруйте и сортируйте задачи по статусу, приоритету или дедлайну. Получайте уведомления о приближении срока выполнения задач, выбирайте удобную тему оформления. Приложение адаптировано под IOS, Android и Web платформы",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: doNotShowAgain,
                  //       onChanged: (bool? value) {
                  //         setState(() {
                  //           doNotShowAgain = value ?? false;
                  //         });
                  //       },
                  //     ),
                  //     Text("Не показывать снова", style: TextStyle(
                  //         color: Theme.of(context).brightness == Brightness.dark
                  //             ? Colors.white
                  //             : Colors.black,
                  //     ),),
                  //   ],
                  // ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (doNotShowAgain) {
                  await _setDoNotShowAgain();
                }
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setDoNotShowAgain() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('infoDialogShown', false);
  }

  Future<bool> shouldShowDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('infoDialogShown') ?? true;
  }