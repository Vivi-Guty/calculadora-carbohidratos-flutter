import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _currentTheme = ThemeData.light();

  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
