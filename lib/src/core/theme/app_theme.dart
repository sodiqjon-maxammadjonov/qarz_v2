import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6200EA);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFB00020);

  static const Color background = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: textColor),
      ),
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        error: error,
        surface: background,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onError: Colors.white,
        onSurface: textColor,
      ),
    );
  }
}
