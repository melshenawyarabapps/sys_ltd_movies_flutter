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
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movies_list_widget.dart';

import '../../../fixtures/movie_fixtures.dart';

class MockMoviesBloc extends MockBloc<MoviesEvent, MoviesState>
    implements MoviesBloc {}

void main() {
  late MockMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockMoviesBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Widget createWidgetUnderTest(MoviesState state) {
    when(() => mockBloc.state).thenReturn(state);
    whenListen(mockBloc, Stream.value(state), initialState: state);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: BlocProvider<MoviesBloc>.value(
          value: mockBloc,
          child: Scaffold(
            body: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state.movies.isNotEmpty) {
                  return MoviesListWidget(
                    movies: state.movies,
                    isLoadingMore: state.status.isLoadingMore,
                  );
                } else if (state.status.isLoading) {
                  return const LoadingWidget();
                } else if (state.status.isError) {
                  return Center(child: Text(state.errorMessage));
                }
                return const Center(child: Text('No movies'));
              },
            ),
          ),
        ),
      ),
    );
  }

  group('MoviesBodyWidget States', () {
    testWidgets('should show LoadingWidget when status is loading',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const MoviesState(status: RequestStatus.loading),
      ));

      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(MoviesListWidget), findsNothing);
    });

    testWidgets('should show MoviesListWidget when movies are loaded',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        MoviesState(
          status: RequestStatus.loaded,
          movies: MovieFixtures.testMovies,
        ),
      ));

      expect(find.byType(MoviesListWidget), findsOneWidget);
      expect(find.byType(LoadingWidget), findsNothing);
    });

    testWidgets('should show error message when status is error',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const MoviesState(
          status: RequestStatus.error,
          errorMessage: 'Test error message',
        ),
      ));

      expect(find.text('Test error message'), findsOneWidget);
      expect(find.byType(MoviesListWidget), findsNothing);
    });

    testWidgets('should show empty message when movies list is empty',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const MoviesState(
          status: RequestStatus.loaded,
          movies: [],
        ),
      ));

      expect(find.text('No movies'), findsOneWidget);
      expect(find.byType(MoviesListWidget), findsNothing);
    });
  });
}


