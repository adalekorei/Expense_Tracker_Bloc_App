import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(backgroundColor: Colors.black),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(fontSize: 12, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 15, color: Colors.white),
    bodyLarge: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(fontSize: 18, color: Colors.black),
    labelLarge: TextStyle(
      fontSize: 28,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Color.fromARGB(255, 255, 200, 200),
    secondary: Color.fromARGB(255, 255, 220, 220),
    tertiary: Color.fromARGB(255, 255, 243, 226),
  ),
);
