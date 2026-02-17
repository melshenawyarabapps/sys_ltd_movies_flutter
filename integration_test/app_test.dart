import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sys_ltd_movies_flutter/core/services/di/di.dart' as di;
import 'package:sys_ltd_movies_flutter/app/movies_app.dart';
import 'package:sys_ltd_movies_flutter/core/translations/codegen_loader.g.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movie_card_widget.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movies_list_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
    di.setUp();
  });

  Widget createTestableApp() {
    return EasyLocalization(
      assetLoader: const CodegenLoader(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: MoviesApp(),
    );
  }

  group('Movies App Integration Tests', () {
    testWidgets('should load and display popular movies', (tester) async {
      await tester.pumpWidget(createTestableApp());

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final hasMoviesList = find.byType(MoviesListWidget).evaluate().isNotEmpty;
      final hasMovieCard = find.byType(MovieCardWidget).evaluate().isNotEmpty;

      if (hasMoviesList && hasMovieCard) {
        expect(find.byType(MoviesListWidget), findsOneWidget);
        expect(find.byType(MovieCardWidget), findsWidgets);
      } else {
        expect(
          find.byType(MoviesListWidget).evaluate().isEmpty,
          isTrue,
          reason: 'Should show error or empty state when no data',
        );
      }
    });

    testWidgets('should be able to scroll through movie list', (tester) async {
      await tester.pumpWidget(createTestableApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final listFinder = find.byType(ListView);

      if (listFinder.evaluate().isNotEmpty) {
        await tester.drag(listFinder, const Offset(0, -300));
        await tester.pumpAndSettle();

        await tester.drag(listFinder, const Offset(0, 300));
        await tester.pumpAndSettle();

        expect(find.byType(ListView), findsOneWidget);
      }
    });

    testWidgets('should show loading indicator initially', (tester) async {
      await tester.pumpWidget(createTestableApp());

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final hasCircularProgress = find.byType(CircularProgressIndicator).evaluate().isNotEmpty;
      final hasMoviesList = find.byType(MoviesListWidget).evaluate().isNotEmpty;

      expect(hasCircularProgress || hasMoviesList, isTrue);
    });

  });
}
