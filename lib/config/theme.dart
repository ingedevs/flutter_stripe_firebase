import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.blue,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black.withOpacity(.04),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    color: Colors.black.withOpacity(.04),
  ),
);
