import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  double _textScaleFactor = 1.0;

  ThemeMode get themeMode => _themeMode;
  double get textScaleFactor => _textScaleFactor;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setTextScale(double factor) {
    _textScaleFactor = factor.clamp(0.8, 1.5);
    notifyListeners();
  }
}
