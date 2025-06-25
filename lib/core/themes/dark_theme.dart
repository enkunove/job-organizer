import 'package:flutter/material.dart';

class DarkTheme {
  static const _primaryColor = Color(0xFF4C5BD4);
  static const _backgroundColor = Color(0xFF121212);
  static const _cardColor = Color(0xFF1E1E1E);
  static const _textColor = Color(0xFFE0E0E0);
  static const _greyColor = Color(0xFF9E9E9E);

  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _backgroundColor,
    primaryColor: _primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: Color(0xFF8E99F3),
      background: _backgroundColor,
      surface: _cardColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: _textColor,
      onSurface: _textColor,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
    ),
    cardTheme: const CardTheme(
      color: _cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.all(12),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w600, color: _textColor),
      bodyMedium: TextStyle(fontSize: 16, color: _textColor),
      bodySmall: TextStyle(fontSize: 14, color: _greyColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        shadowColor: _primaryColor.withOpacity(0.5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _cardColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: _greyColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _greyColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      labelStyle: TextStyle(color: _textColor),
    ),
    iconTheme: const IconThemeData(color: _primaryColor),
    dividerTheme: DividerThemeData(
      color: _greyColor.withOpacity(0.3),
      thickness: 1,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(_primaryColor),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: _primaryColor,
      textColor: _textColor,
    ),
  );
}
