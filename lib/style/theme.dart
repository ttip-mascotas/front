import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: colorScheme,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
);

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.purple.shade200),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
);

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
