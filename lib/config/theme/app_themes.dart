import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: defaultAppBarTheme(),
    floatingActionButtonTheme: defaultFloatingActionButtonTheme(),
    elevatedButtonTheme: defaultElevatedButtonThemeData(),
  );
}

AppBarTheme defaultAppBarTheme() {
  return AppBarTheme(
    color: Colors.green[900],
  );
}

FloatingActionButtonThemeData defaultFloatingActionButtonTheme() {
  return FloatingActionButtonThemeData(
    backgroundColor: Colors.green[900],
  );
}

ElevatedButtonThemeData defaultElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
    ),
  );
}
