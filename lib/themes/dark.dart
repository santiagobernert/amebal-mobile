import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black54,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.black12,
        labelStyle: TextStyle(color: Colors.grey),
        iconColor: Colors.grey
    ),
    tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.lightBlueAccent,
        labelColor: Colors.white
    ),
);
