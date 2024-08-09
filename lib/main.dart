import 'package:calculadora_de_carbohidratos/login/login_screen.dart';
import 'package:calculadora_de_carbohidratos/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      home: LoginScreen(),
      theme: themeNotifier.currentTheme,
    );
  }
}
