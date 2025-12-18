import 'package:flutter/material.dart';
import 'package:tasabeeh/homepage.dart';
import 'package:tasabeeh/settings.dart';
import 'package:tasabeeh/about.dart';
import 'package:tasabeeh/support.dart';
import 'package:tasabeeh/azkar.dart';
import 'package:tasabeeh/add_zekr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0XFF101827),
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        "home": (context) => const Homepage(),
        "settings": (context) => const Settings(),
        "about": (context) => const About(),
        "support": (context) => const Support(),
        "azkar": (context) => const Azkar(),
        "addzekr": (context) => const AddZekr(),
      },
    );
  }
}
