import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TestPustakApp());
}

class TestPustakApp extends StatefulWidget {
  const TestPustakApp({super.key});

  static void of(BuildContext context, {bool isThemeDark = false}) {
    context.findAncestorStateOfType<_TestPustakAppState>()?.changeTheme(isThemeDark);
  }

  @override
  State<TestPustakApp> createState() => _TestPustakAppState();
}

class _TestPustakAppState extends State<TestPustakApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(bool isThemeDark) {
    setState(() {
      _themeMode = isThemeDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TestPustak',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: const LoginScreen(),
    );
  }
}