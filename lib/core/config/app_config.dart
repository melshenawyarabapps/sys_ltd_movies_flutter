import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/services/di/di.dart';
import 'package:sys_ltd_movies_flutter/core/services/observers/bloc_lifecycle_observer.dart';

class AppConfig {
  static AppConfig? _instance;

  static AppConfig get instance => _instance ??= AppConfig._();

  AppConfig._();

  Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    setUp();
    Bloc.observer = BlocLifecycleObserver.instance;
  }
}
