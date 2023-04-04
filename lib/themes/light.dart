import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xff0a4b8f),
        unselectedItemColor: Color(0xff444444)
    )
);

