import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sys_ltd_movies_flutter/core/routing/app_router.dart';
import 'package:sys_ltd_movies_flutter/core/routing/app_routes.dart';
import 'package:sys_ltd_movies_flutter/core/themes/app_theme.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_constants.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp._();

  factory MoviesApp() {
    _instance ??= const MoviesApp._();
    return _instance!;
  }

  static MoviesApp? _instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, _) => MaterialApp(
        title: AppConstants.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.movies,
      ),
    );
  }
}
