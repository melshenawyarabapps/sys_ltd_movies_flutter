import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sys_ltd_movies_flutter/app/movies_app.dart';
import 'package:sys_ltd_movies_flutter/core/config/app_config.dart';
import 'package:sys_ltd_movies_flutter/core/translations/codegen_loader.g.dart';

Future<void> main() async {
  await AppConfig.instance.initApp();
  runApp(
    EasyLocalization(
      assetLoader: const CodegenLoader(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: MoviesApp(),
    ),
  );
}