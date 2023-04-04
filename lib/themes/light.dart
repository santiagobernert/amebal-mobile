import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xff0a4b8f),
        unselectedItemColor: Color(0xff444444)
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white30,
        labelStyle: TextStyle(color: Colors.black54),
        iconColor: Colors.black54
    )
);

