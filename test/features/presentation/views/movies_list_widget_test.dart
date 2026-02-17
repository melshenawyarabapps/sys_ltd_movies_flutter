import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/core/enums/api_enums.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/loading_widget.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_bloc.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_event.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_state.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movie_card_widget.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movies_list_widget.dart';

import '../../../fixtures/movie_fixtures.dart';

class MockMoviesBloc extends MockBloc<MoviesEvent, MoviesState>
    implements MoviesBloc {}

void main() {
  late MockMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockMoviesBloc();
    when(() => mockBloc.state).thenReturn(
      MoviesState(
        status: RequestStatus.loaded,
        movies: MovieFixtures.testMovies,
      ),
    );
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget createWidgetUnderTest({
    bool isLoadingMore = false,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: BlocProvider<MoviesBloc>.value(
          value: mockBloc,
          child: Scaffold(
            body: MoviesListWidget(
              movies: MovieFixtures.testMovies,
              isLoadingMore: isLoadingMore,
            ),
          ),
        ),
      ),
    );
  }

  group('MoviesListWidget', () {
    testWidgets('should display list of movies', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(MovieCardWidget), findsNWidgets(3));
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should show loading indicator when isLoadingMore is true',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(isLoadingMore: true));

      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pump();

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('should not show loading indicator when isLoadingMore is false',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(isLoadingMore: false));

      expect(find.byType(LoadingWidget), findsNothing);
    });

    testWidgets('should dispatch loadMore event when scrolled near bottom',
        (tester) async {
      final manyMovies = List.generate(
        20,
        (index) => MovieFixtures.testMovies.first,
      );
      when(() => mockBloc.state).thenReturn(
        MoviesState(
          status: RequestStatus.loaded,
          movies: manyMovies,
        ),
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: BlocProvider<MoviesBloc>.value(
              value: mockBloc,
              child: Scaffold(
                body: MoviesListWidget(
                  movies: manyMovies,
                  isLoadingMore: false,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.drag(find.byType(ListView), const Offset(0, -5000));
      await tester.pump();

      verify(() => mockBloc.add(const MoviesEvent.loadMore())).called(greaterThan(0));
    });
  });
}

