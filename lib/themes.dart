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
      primaryContainer: const Color(0xff1A2238),
      surface: const Color(0xff162033),
      onPrimary: const Color(0xff101827),
      onPrimaryContainer: const Color(0xffEAEAEA),
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

  //Green Theme
  static ThemeData greenTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xff0E7C5B),
      secondary: Color(0xffE6C15A),
      primaryContainer: Color.fromARGB(255, 255, 244, 215),
      secondaryContainer: Color(0xffEFE7DC),
      surface: Color(0xffFAF9F6),
      onPrimary: Colors.white,
      onSecondary: Color(0xff1C2B2A),
      onPrimaryContainer: Color(0xff1C2B2A),
      onSurface: Color(0xff1C2B2A),
    ),
    scaffoldBackgroundColor: const Color(0xffFAF9F6),
    cardTheme: const CardThemeData(
      color: Color(0xffF4F1EC),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff0E7C5B),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0E7C5B),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xffFAF9F6),
      selectedItemColor: Color(0xff0E7C5B),
      unselectedItemColor: Color(0xff9EADA7),
      elevation: 0,
    ),
  );
}
