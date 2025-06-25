import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/routing/app_routing.dart';
import 'package:test_task/core/themes/dark_theme.dart';
import 'package:test_task/core/themes/light_theme.dart';
import 'package:test_task/core/themes/theme_provider.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            routerConfig: _appRouter.config(),
            theme: LightTheme.theme,
            darkTheme: DarkTheme.theme,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
