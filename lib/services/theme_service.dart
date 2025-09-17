import 'package:hive_flutter/hive_flutter.dart';

class ThemeService {
  static const String _boxName = 'theme_box';
  static const String _themeKey = 'is_dark_mode';
  
  static Box? _box;

  // Initialize Hive and open the theme box
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  // Get the current theme mode
  static bool get isDarkMode {
    return _box?.get(_themeKey, defaultValue: false) ?? false;
  }

  // Set the theme mode
  static Future<void> setDarkMode(bool isDark) async {
    await _box?.put(_themeKey, isDark);
  }

  // Toggle between light and dark mode
  static Future<bool> toggleTheme() async {
    final newTheme = !isDarkMode;
    await setDarkMode(newTheme);
    return newTheme;
  }

  // Close the Hive box (call this when app is disposed)
  static Future<void> close() async {
    await _box?.close();
  }
}