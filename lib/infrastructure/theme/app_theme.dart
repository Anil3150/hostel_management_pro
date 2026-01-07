import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    fontFamily:  'Poppins',
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
  );
}
