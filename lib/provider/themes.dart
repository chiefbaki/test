import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  // appBarTheme: AppBarTheme(
  //   color: Colors.deepPurple
  // )
);

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  // appBarTheme: AppBarTheme(color: Colors.green),
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
);
