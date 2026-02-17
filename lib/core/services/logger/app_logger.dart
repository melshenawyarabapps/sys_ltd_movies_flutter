import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static AppLogger? _instance;

  static AppLogger get instance => _instance ??= AppLogger._();

  void info(String message) {
    if (!kDebugMode) {
      return;
    }
    log('ℹ️ INFO: $message');
  }

  void warn(String message) {
    if (!kDebugMode) {
      return;
    }
    log('⚠️ WARNING: $message');
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (!kDebugMode) {
      return;
    }
    log('❌ ERROR: $message \n$error', stackTrace: stackTrace);
  }

  void debug(String message) {
    if (!kDebugMode) {
      return;
    }
    log('🐞 DEBUG: $message');
  }
}
