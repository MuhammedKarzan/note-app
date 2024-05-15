import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background:Color.fromARGB(255, 223, 49, 18),
    primary: Colors.white,
    secondary: Colors.black,
              )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
   colorScheme: const ColorScheme.dark(
    background:Color.fromARGB(255, 59, 57, 57),
    primary: Colors.black,
    secondary: Color.fromARGB(255, 255, 254, 254),
              )
);