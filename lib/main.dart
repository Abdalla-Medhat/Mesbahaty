import 'package:flutter/material.dart';
import 'package:tasabeeh/homepage.dart';
import 'package:tasabeeh/settings.dart';
import 'package:tasabeeh/about.dart';
import 'package:tasabeeh/support.dart';
import 'package:tasabeeh/azkar.dart';
import 'package:tasabeeh/add_zekr.dart';
import 'package:tasabeeh/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData currentTheme = AppThemes.goldenTheme;

  changeTheme(ThemeData newTheme) {
    setState(() {
      currentTheme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
      home: const Homepage(),
      routes: {
        "home": (context) => const Homepage(),
        "settings": (context) => Settings(onThemeChanged: changeTheme),
        "about": (context) => const About(),
        "support": (context) => const Support(),
        "azkar": (context) => const Azkar(),
        "addzekr": (context) => const AddZekr(),
      },
    );
  }
}
