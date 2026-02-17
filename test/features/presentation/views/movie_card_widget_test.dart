import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_constants.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movie_card_widget.dart';

import '../../../fixtures/movie_fixtures.dart';

void main() {
  group('MovieCardWidget', () {
    Widget createWidgetUnderTest() {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: MovieCardWidget(movie: MovieFixtures.testMovie),
          ),
        ),
      );
    }

    testWidgets('should display movie title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(MovieFixtures.testMovie.title), findsOneWidget);
    });

    testWidgets('should display movie overview', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(MovieFixtures.testMovie.overview), findsOneWidget);
    });

    testWidgets('should have Card widget', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should have InkWell for tap interaction', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should invoke method channel on tap', (tester) async {
      final List<MethodCall> methodCalls = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel(AppConstants.channelName),
        (MethodCall methodCall) async {
          methodCalls.add(methodCall);
          return null;
        },
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(methodCalls.length, 1);
      expect(methodCalls.first.method, AppConstants.eventName);
      expect(
        methodCalls.first.arguments,
        {'movieId': MovieFixtures.testMovie.id},
      );

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel(AppConstants.channelName),
        null,
      );
    });
  });
}

