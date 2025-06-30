import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_task/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('управление досками', () {
    testWidgets('создание доски', (WidgetTester tester) async {
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

      await tester.enterText(find.widgetWithText(TextField, 'Название'), 'Доска для теста');
      await tester.enterText(find.widgetWithText(TextField, 'Описание (необязательно)'), 'Описание доски');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Создать'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Доска для теста'), findsOneWidget);
    });

    testWidgets('Редактирование доски через диалог', (WidgetTester tester) async {
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

      final boardTitleFinder = find.text('Доска для теста');
      expect(boardTitleFinder, findsOneWidget);

      final editButton = find.descendant(
        of: find.ancestor(of: boardTitleFinder, matching: find.byType(Row)),
        matching: find.byIcon(Icons.edit),
      );
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      expect(find.text('Редактировать доску'), findsOneWidget);

      await tester.enterText(find.widgetWithText(TextField, 'Название'), 'Доска отредактирована');
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Сохранить'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Доска отредактирована'), findsOneWidget);
    });

    testWidgets('Архивирование доски', (WidgetTester tester) async {
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

      final boardTitleFinder = find.text('Доска отредактирована');
      expect(boardTitleFinder, findsOneWidget);

      final editButton = find.descendant(
        of: find.ancestor(of: boardTitleFinder, matching: find.byType(Row)),
        matching: find.byIcon(Icons.edit),
      );
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      expect(find.text('Редактировать доску'), findsOneWidget);

      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Сохранить'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Доска отредактирована'), findsNothing);
    });
  });
}
