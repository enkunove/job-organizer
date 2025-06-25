import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/themes/theme_provider.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkTheme = themeProvider.isDarkMode;

    return GestureDetector(
      onTap: themeProvider.toggleTheme,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 32,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkTheme ? Colors.black : Colors.yellow[700],
          border: Border.all(color: isDarkTheme ? Colors.white : Colors.black),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isDarkTheme ? 0 : 30,
              right: isDarkTheme ? 30 : 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(
                  isDarkTheme ? Icons.nights_stay : Icons.wb_sunny,
                  color: isDarkTheme ? Colors.indigo : Colors.orange,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
