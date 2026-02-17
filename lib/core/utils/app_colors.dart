import 'package:flutter/material.dart';

abstract class AppDarkColors {
  const AppDarkColors();

  static const Color primaryBrand = Color(0xFF367AFF);

  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color onBackground = Color(0xFFE6E1E5);
  static const Color onSurface = Color(0xFFE6E1E5);

  static const Color error = Colors.red;
}

abstract class AppLightColors {
  const AppLightColors();

  static const Color primaryBrand = Color(0xFF155EE5);

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1C1B1F);
  static const Color onSurface = Color(0xFF1C1B1F);

  static const Color error = Colors.red;
}
