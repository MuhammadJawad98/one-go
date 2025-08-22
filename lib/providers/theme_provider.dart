import 'package:flutter/material.dart';

import '../utils/app_sharedpref.dart';
import '../utils/helper_functions.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkModeEnabled => _themeMode == ThemeMode.dark;
  ThemeProvider() {
    _initializeTheme();
  }

  // Call this during app initialization
  Future<void> _initializeTheme() async {
    final theme = await HelperFunctions.getFromPreference(AppSharedPref.theme);
    if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    notifyListeners();
  }

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    HelperFunctions.saveInPreference(AppSharedPref.theme,isDark ? 'dark' : 'light');
    notifyListeners();
  }
}
