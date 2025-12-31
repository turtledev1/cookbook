import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    const green1 = Color.fromRGBO(179, 232, 180, 1);
    const green2 = Color.fromRGBO(108, 185, 110, 1);
    const green3 = Color.fromRGBO(31, 137, 39, 1);

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: green1,
        brightness: Brightness.light,
        primary: green1,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: green1,
        foregroundColor: Colors.black87,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: green1,
        labelStyle: TextStyle(color: Colors.black87),
        labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        padding: EdgeInsets.zero,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: green2,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black87,
          side: const BorderSide(color: green2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: green3,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: green3,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    const appBarColor = Color(0xFF2E7D32);

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
        primary: const Color(0xFF66BB6A),
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF1E1E1E),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: appBarColor,
        labelStyle: TextStyle(color: Colors.white),
        labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        padding: EdgeInsets.zero,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: appBarColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: appBarColor),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF66BB6A),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: appBarColor,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
    );
  }
}
