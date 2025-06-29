import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_task/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('цправление задачами', () {
    testWidgets('создание доски, создание задачи', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Уже есть аккаунт? Войти'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'admin@gmail.com');
      await tester.enterText(find.widgetWithText(TextField, 'Пароль'), 'admin123');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Войти'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Мои доски задач'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Название'), 'Доска для задач');
      await tester.enterText(find.widgetWithText(TextField, 'Описание (необязательно)'), 'Описание доски задач');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Создать'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Доска для задач'), findsOneWidget);

      await tester.tap(find.text('Доска для задач'));
      await tester.pumpAndSettle();

      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);

      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Название'), 'Новая задача');
      await tester.enterText(find.widgetWithText(TextField, 'Комментарий'), 'Комментарий к задаче');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Создать'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Новая задача'), findsOneWidget);
    });

    testWidgets('Редактирование задачи', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Уже есть аккаунт? Войти'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'admin@gmail.com');
      await tester.enterText(find.widgetWithText(TextField, 'Пароль'), 'admin123');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Войти'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.text('Доска для задач'));
      await tester.pumpAndSettle();

      final taskFinder = find.text('Новая задача');
      expect(taskFinder, findsOneWidget);

      await tester.tap(taskFinder);
      await tester.pumpAndSettle();

      final editIcon = find.byIcon(Icons.edit);
      expect(editIcon, findsOneWidget);

      await tester.tap(editIcon);
      await tester.pumpAndSettle();

      final titleField = find.widgetWithText(TextField, 'Название');
      await tester.enterText(titleField, 'Задача отредактирована');
      await tester.pumpAndSettle();

      final saveButton = find.widgetWithText(ElevatedButton, 'Сохранить');
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Задача отредактирована'), findsOneWidget);
    });

    testWidgets('Удаление задачи', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Уже есть аккаунт? Войти'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Email'), 'admin@gmail.com');
      await tester.enterText(find.widgetWithText(TextField, 'Пароль'), 'admin123');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Войти'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.text('Доска для задач'));
      await tester.pumpAndSettle();

      final taskFinder = find.text('Задача отредактирована');
      expect(taskFinder, findsOneWidget);

      await tester.tap(taskFinder);
      await tester.pumpAndSettle();

      final editIcon = find.byIcon(Icons.edit);
      expect(editIcon, findsOneWidget);

      await tester.tap(editIcon);
      await tester.pumpAndSettle();

      final deleteButton = find.byIcon(Icons.delete_outline);
      await tester.tap(deleteButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Задача отредактирована'), findsNothing);
    });
  });
}
