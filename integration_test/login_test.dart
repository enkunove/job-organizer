import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_task/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('тест логина admin', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final Finder emailField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.labelText == 'Email',
    );
    await tester.enterText(emailField, 'admin@gmail.com');

    final Finder passwordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.labelText == 'Пароль',
    );
    await tester.enterText(passwordField, 'admin123');

    await tester.pumpAndSettle();

    final Finder loginButton = find.widgetWithText(FilledButton, 'Войти');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Мои доски задач'), findsOneWidget);
  });
}
