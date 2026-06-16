import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider
    extends ChangeNotifier {

  ThemeMode _currentTheme =
      ThemeMode.dark;

  ThemeMode get currentTheme =>
      _currentTheme;

  bool get isDarkMode =>

      _currentTheme ==
          ThemeMode.dark;

  ThemeProvider() {

    loadTheme();
  }

  Future<void>
      toggleTheme() async {

    if (_currentTheme ==
        ThemeMode.dark) {

      _currentTheme =
          ThemeMode.light;
    }

    else {

      _currentTheme =
          ThemeMode.dark;
    }

    notifyListeners();

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setBool(

      'isDarkMode',

      isDarkMode,
    );
  }

  Future<void>
      loadTheme() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final isDark =
        prefs.getBool(
              'isDarkMode',
            ) ??
            true;

    _currentTheme = isDark

        ? ThemeMode.dark

        : ThemeMode.light;

    notifyListeners();
  }
}