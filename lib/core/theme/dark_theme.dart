import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,

    useMaterial3: true,

    scaffoldBackgroundColor: const Color(
      0xFF0F172A,
    ),

    cardColor: const Color(
      0xFF1E293B,
    ),

    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade400,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}