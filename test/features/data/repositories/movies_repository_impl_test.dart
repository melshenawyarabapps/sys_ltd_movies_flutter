import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/features/data/repositories/movies_repository_impl.dart';

import '../../../fixtures/mocks.dart';
import '../../../fixtures/movie_fixtures.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MoviesRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });

  group('MoviesRepositoryImpl', () {
    group('getPopularMovies', () {
      const testPage = 1;
      const testTotalPages = 10;

      test('should return movies when device is connected', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getPopularMovies(testPage))
            .thenAnswer((_) async => (MovieFixtures.testMovieModels, testTotalPages));

        final result = await repository.getPopularMovies(testPage);

        expect(result.$1.length, 3);
        expect(result.$2, testTotalPages);
        expect(result.$1.first.id, 1);
        expect(result.$1.first.title, 'Test Movie 1');
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.getPopularMovies(testPage)).called(1);
      });

      test('should throw NoInternetException when device is not connected',
          () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        expect(
          () => repository.getPopularMovies(testPage),
          throwsA(isA<NoInternetException>()),
        );
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNever(() => mockRemoteDataSource.getPopularMovies(any()));
      });

      test('should rethrow exception when data source fails', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getPopularMovies(testPage))
            .thenThrow(const ServerException(localeKey: 'error'));

        expect(
          () => repository.getPopularMovies(testPage),
          throwsA(isA<ServerException>()),
        );
      });

      test('should convert MovieModel to Movie entity', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getPopularMovies(testPage))
            .thenAnswer((_) async => (MovieFixtures.testMovieModels, testTotalPages));

        final result = await repository.getPopularMovies(testPage);

        expect(result.$1, isA<List>());
        expect(result.$1.first.id, MovieFixtures.testMovieModels.first.id);
        expect(result.$1.first.title, MovieFixtures.testMovieModels.first.title);
      });

      test('should return correct total pages from data source', () async {
        const expectedTotalPages = 25;
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getPopularMovies(testPage))
            .thenAnswer((_) async => (MovieFixtures.testMovieModels, expectedTotalPages));

        final result = await repository.getPopularMovies(testPage);

        expect(result.$2, expectedTotalPages);
      });
    });
  });
}

