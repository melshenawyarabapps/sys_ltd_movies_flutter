import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelper {
  TestHelper._();

  static Widget wrapWithMaterialApp(
    Widget child, {
    Size designSize = const Size(375, 812),
  }) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, _) => MaterialApp(
        home: child,
      ),
    );
  }

  static Widget wrapWithLocalization(
    Widget child, {
    Size designSize = const Size(375, 812),
  }) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: Builder(
        builder: (context) => ScreenUtilInit(
          designSize: designSize,
          builder: (context, _) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: child,
          ),
        ),
      ),
    );
  }

  static Future<void> initializeLocalization() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpAndSettleWithTimeout({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    await pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      timeout,
    );
  }
}

