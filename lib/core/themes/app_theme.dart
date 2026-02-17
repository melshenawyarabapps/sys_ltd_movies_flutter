import 'package:flutter/material.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_colors.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_padding.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_radius.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppLightColors.primaryBrand,
      brightness: Brightness.light,
      surface: AppLightColors.surface,
      onSurface: AppLightColors.onSurface,
      background: AppLightColors.background,
      error: AppLightColors.error,
    ),
    scaffoldBackgroundColor: AppLightColors.background,
    cardTheme: CardThemeData(
      color: AppLightColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.all(AppRadius.r12)),
      clipBehavior: Clip.antiAlias,
      margin: AppPadding.hvPadding(
        width: AppPadding.p16,
        height: AppPadding.p8,
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppLightColors.surface,
      surfaceTintColor: Colors.transparent,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppDarkColors.primaryBrand,
      brightness: Brightness.dark,
      surface: AppDarkColors.surface,
      onSurface: AppDarkColors.onSurface,
      background: AppDarkColors.background,
      error: AppDarkColors.error,
    ),
    scaffoldBackgroundColor: AppDarkColors.background,
    cardTheme: CardThemeData(
      color: AppDarkColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.all(AppRadius.r12)),
      clipBehavior: Clip.antiAlias,
      margin: AppPadding.hvPadding(
        width: AppPadding.p16,
        height: AppPadding.p8,
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppDarkColors.surface,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
