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

  //Green Theme
  static ThemeData greenTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4CAF50), // أخضر أساسي
    ).copyWith(
      // اللون الأساسي
      primary: const Color(0xFF4CAF50), // أخضر مريح
      onPrimary: Colors.white, // نص أبيض على الأزرار
      // const Color(0xFF0B3D1E), // نص أبيض واضح

      // الكونتينرز والكروت
      primaryContainer: const Color(0xFFE8F5E9), // أخضر فاتح جدًا
      onPrimaryContainer: const Color(0xFF1B5E20), // أخضر غامق للنص

      // الخلفيات
      surface: const Color(0xFFF9FFF9), // أبيض مائل للأخضر
      onSurface: const Color(0xFF1F1F1F),

      background: const Color(0xFFF5FBF6),
      onBackground: const Color(0xFF1F1F1F),

      // عناصر ثانوية
      secondary: const Color(0xFF81C784), // أخضر فاتح
      onSecondary: const Color(0xFF1B5E20),

      // التنبيهات
      error: const Color(0xFFD32F2F),
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5FBF6),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFE8F5E9),
      elevation: 4,
      shadowColor: const Color(0xFF4CAF50).withAlpha(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF9FFF9),
      selectedItemColor: Color(0xFF4CAF50),
      unselectedItemColor: Color(0xFF9E9E9E),
      elevation: 12,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4CAF50),
      foregroundColor: Colors.white,
    ),
  );
}
