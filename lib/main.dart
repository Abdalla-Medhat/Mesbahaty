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

  loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString("theme");
    if (theme != null) {
      if (theme == "golden") {
        changeTheme(AppThemes.goldenTheme);
      } else {
        changeTheme(AppThemes.greenTheme);
      }
    } else {
      currentTheme = AppThemes.goldenTheme;
    }
  }

  void changeTheme(ThemeData newTheme) {
    setState(() {
      currentTheme = newTheme;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTheme();
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
