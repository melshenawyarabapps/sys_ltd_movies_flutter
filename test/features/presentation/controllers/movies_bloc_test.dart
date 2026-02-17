import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/core/enums/api_enums.dart';
import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/core/translations/locale_keys.g.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_bloc.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_event.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_state.dart';

import '../../../fixtures/mocks.dart';
import '../../../fixtures/movie_fixtures.dart';

void main() {
  late MoviesBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = MoviesBloc(mockGetPopularMovies);
  });

  tearDown(() {
    bloc.close();
  });

  group('MoviesBloc', () {
    test('initial state should be MoviesState with default values', () {
      expect(bloc.state, const MoviesState());
      expect(bloc.state.status, RequestStatus.initial);
      expect(bloc.state.movies, isEmpty);
      expect(bloc.state.currentPage, 0);
      expect(bloc.state.hasReachedMax, false);
    });

    group('MoviesEvent.fetch', () {
      const testTotalPages = 10;

      blocTest<MoviesBloc, MoviesState>(
        'emits [loading, loaded] when fetch is successful',
        build: () {
          when(
            () => mockGetPopularMovies(1),
          ).thenAnswer((_) async => (MovieFixtures.testMovies, testTotalPages));
          return MoviesBloc(mockGetPopularMovies);
        },
        act: (bloc) => bloc.add(const MoviesEvent.fetch()),
        expect: () => [
          const MoviesState(status: RequestStatus.loading),
          MoviesState(
            status: RequestStatus.loaded,
            movies: MovieFixtures.testMovies,
            currentPage: 1,
            totalPages: testTotalPages,
            hasReachedMax: false,
          ),
        ],
        verify: (_) {
          verify(() => mockGetPopularMovies(1)).called(1);
        },
      );

      blocTest<MoviesBloc, MoviesState>(
        'emits [loading, error] when fetch fails',
        build: () {
          when(
            () => mockGetPopularMovies(1),
          ).thenThrow(ServerException(localeKey: LocaleKeys.unexpectedError));
          return MoviesBloc(mockGetPopularMovies);
        },
        act: (bloc) => bloc.add(const MoviesEvent.fetch()),
        expect: () => [
          const MoviesState(status: RequestStatus.loading),
          isA<MoviesState>()
              .having((s) => s.status, 'status', RequestStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotEmpty),
        ],
      );

      blocTest<MoviesBloc, MoviesState>(
        'sets hasReachedMax to true when currentPage equals totalPages',
        build: () {
          when(
            () => mockGetPopularMovies(1),
          ).thenAnswer((_) async => (MovieFixtures.testMovies, 1));
          return MoviesBloc(mockGetPopularMovies);
        },
        act: (bloc) => bloc.add(const MoviesEvent.fetch()),
        expect: () => [
          const MoviesState(status: RequestStatus.loading),
          MoviesState(
            status: RequestStatus.loaded,
            movies: MovieFixtures.testMovies,
            currentPage: 1,
            totalPages: 1,
            hasReachedMax: true,
          ),
        ],
      );
    });

    group('MoviesEvent.loadMore', () {
      const testTotalPages = 10;

      blocTest<MoviesBloc, MoviesState>(
        'emits [loadingMore, loaded] when loadMore is successful',
        build: () {
          when(() => mockGetPopularMovies(2)).thenAnswer(
            (_) async => (MovieFixtures.testMoviesPage2, testTotalPages),
          );
          return MoviesBloc(mockGetPopularMovies);
        },
        seed: () => MoviesState(
          status: RequestStatus.loaded,
          movies: MovieFixtures.testMovies,
          currentPage: 1,
          totalPages: testTotalPages,
        ),
        act: (bloc) => bloc.add(const MoviesEvent.loadMore()),
        expect: () => [
          MoviesState(
            status: RequestStatus.loadingMore,
            movies: MovieFixtures.testMovies,
            currentPage: 1,
            totalPages: testTotalPages,
          ),
          MoviesState(
            status: RequestStatus.loaded,
            movies: [
              ...MovieFixtures.testMovies,
              ...MovieFixtures.testMoviesPage2,
            ],
            currentPage: 2,
            totalPages: testTotalPages,
            hasReachedMax: false,
          ),
        ],
      );

      blocTest<MoviesBloc, MoviesState>(
        'does not emit when hasReachedMax is true',
        build: () => MoviesBloc(mockGetPopularMovies),
        seed: () => MoviesState(
          status: RequestStatus.loaded,
          movies: MovieFixtures.testMovies,
          currentPage: 10,
          totalPages: 10,
          hasReachedMax: true,
        ),
        act: (bloc) => bloc.add(const MoviesEvent.loadMore()),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetPopularMovies(any()));
        },
      );

      blocTest<MoviesBloc, MoviesState>(
        'does not emit when already loading more',
        build: () => MoviesBloc(mockGetPopularMovies),
        seed: () => MoviesState(
          status: RequestStatus.loadingMore,
          movies: MovieFixtures.testMovies,
          currentPage: 1,
          totalPages: 10,
        ),
        act: (bloc) => bloc.add(const MoviesEvent.loadMore()),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetPopularMovies(any()));
        },
      );

      blocTest<MoviesBloc, MoviesState>(
        'emits [loadingMore, error] when loadMore fails',
        build: () {
          when(
            () => mockGetPopularMovies(2),
          ).thenThrow(ServerException(localeKey: LocaleKeys.unexpectedError));
          return MoviesBloc(mockGetPopularMovies);
        },
        seed: () => MoviesState(
          status: RequestStatus.loaded,
          movies: MovieFixtures.testMovies,
          currentPage: 1,
          totalPages: 10,
        ),
        act: (bloc) => bloc.add(const MoviesEvent.loadMore()),
        expect: () => [
          MoviesState(
            status: RequestStatus.loadingMore,
            movies: MovieFixtures.testMovies,
            currentPage: 1,
            totalPages: 10,
          ),
          isA<MoviesState>().having(
            (s) => s.status,
            'status',
            RequestStatus.error,
          ),
        ],
      );

      blocTest<MoviesBloc, MoviesState>(
        'sets hasReachedMax to true when reaching last page',
        build: () {
          when(
            () => mockGetPopularMovies(10),
          ).thenAnswer((_) async => (MovieFixtures.testMoviesPage2, 10));
          return MoviesBloc(mockGetPopularMovies);
        },
        seed: () => MoviesState(
          status: RequestStatus.loaded,
          movies: MovieFixtures.testMovies,
          currentPage: 9,
          totalPages: 10,
        ),
        act: (bloc) => bloc.add(const MoviesEvent.loadMore()),
        expect: () => [
          MoviesState(
            status: RequestStatus.loadingMore,
            movies: MovieFixtures.testMovies,
            currentPage: 9,
            totalPages: 10,
          ),
          MoviesState(
            status: RequestStatus.loaded,
            movies: [
              ...MovieFixtures.testMovies,
              ...MovieFixtures.testMoviesPage2,
            ],
            currentPage: 10,
            totalPages: 10,
            hasReachedMax: true,
          ),
        ],
      );
    });
  });
}
