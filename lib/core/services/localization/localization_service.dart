import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class LocalizationService {
  String getCurrentLanguageCode();

  String getCurrentLanguageWithCountry();
}

class LocalizationServiceImpl implements LocalizationService {
  final BuildContext? _context;

  const LocalizationServiceImpl([this._context]);

  @override
  String getCurrentLanguageCode() {
    if (_context != null) {
      return _context.locale.languageCode;
    }
    return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }

  @override
  String getCurrentLanguageWithCountry() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'ar':
        return 'ar-EG';
      default:
        return 'en-US';
    }
  }
}
