import "package:flutter/material.dart";

/// Defines the themes used in the application.
class AppThemes {
  //Golden Theme
  static ThemeData goldenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffF4A300),
    ).copyWith(
      primary: const Color(0xffF4A300),
      secondary: const Color(0xffF4A300),
      primaryContainer: const Color(0xff1A2238), // كحلي غامق للكروت
      surface: const Color(0xff162033),

      background: const Color(0xff101827),
      onPrimary: const Color(0xff101827), // نص على الزر
      onPrimaryContainer: const Color(0xffEAEAEA), // نص فاتح
      onSecondary: const Color(0xff101827),
      onSurface: const Color(0xffEAEAEA),
    ),
    scaffoldBackgroundColor: const Color(0XFF101827),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xffF4A300),
        foregroundColor: const Color(0xff101827),
        elevation: 0,
      ),
    ),
  );

  // ThemeData(
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: const Color(0xffF4A300),
  //   ).copyWith(),
  //   scaffoldBackgroundColor: const Color(0XFF101827),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //     shape: const CircleBorder(),
  //     backgroundColor: const Color(0xffF4A300),
  //   )),
  // );
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
