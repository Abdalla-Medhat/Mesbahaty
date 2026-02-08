import "package:flutter/material.dart";

/// Defines the themes used in the application.
class AppThemes {
  //Golden Theme
  static ThemeData goldenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffF4A300),
    ).copyWith(brightness: Brightness.light),
    scaffoldBackgroundColor: const Color(0XFF101827),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      backgroundColor: const Color(0xffF4A300),
    )),
  );
  //Green Theme
  static ThemeData greenTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
      ).copyWith(
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF00C853),
        foregroundColor: const Color(0xFFFFFFFF),
      )),
      scaffoldBackgroundColor: const Color(0xFF121B16));
}
