import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      colorScheme: isDarkTheme
          ? const ColorScheme.dark(
              primary: Color(0xFF26282F),
              secondary: Colors.black,
              tertiary: Colors.white,
              brightness: Brightness.dark)
          : const ColorScheme.light(
              primary: Color(0xFF26282F),
              secondary: Colors.white,
              tertiary: Color(0xFF26282F),
              brightness: Brightness.light),
    );
  }
}
