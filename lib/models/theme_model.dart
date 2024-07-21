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
      primaryColor: const Color.fromARGB(255, 250, 205, 126),
      hintColor: const Color.fromARGB(255, 250, 205, 126),
      scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 247),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromARGB(255, 250, 205, 126),
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 250, 205, 126),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 250, 205, 126),
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 250, 205, 126),
        secondary: Color.fromARGB(255, 250, 205, 126),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Color.fromARGB(255, 250, 194, 96),
        selectionHandleColor: Colors.black,
      ),
    );
  }

  ThemeData get _darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: const Color.fromARGB(255, 250, 205, 126),
      hintColor: const Color.fromARGB(255, 250, 205, 126),
      scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromARGB(255, 250, 205, 126),
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 250, 205, 126),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 250, 205, 126),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 250, 205, 126),
        secondary: Color.fromARGB(255, 250, 205, 126),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Color.fromARGB(255, 250, 194, 96),
        selectionHandleColor: Colors.black,
      ),
    );
  }
}
