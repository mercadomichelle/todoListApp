import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void setDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  ThemeData get _lightTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 76, 43, 134),
      colorScheme: ColorScheme.light(
        primary: const Color.fromARGB(255, 76, 43, 134),
        secondary: Color.fromARGB(255, 76, 43, 134),
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 76, 43, 134),
        foregroundColor: Colors.white,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black54),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 224, 224, 224)!,
      dividerColor: Colors.grey,
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      primaryColor: Colors.teal,
      colorScheme: ColorScheme.dark(
        primary: Colors.teal,
        secondary: Colors.deepOrange,
        surface: Colors.grey[900]!,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey[850]!,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        titleMedium: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      scaffoldBackgroundColor: Colors.grey[900]!,
      dividerColor: Colors.grey[700],
    );
  }
}
