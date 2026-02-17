import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';
import 'package:sys_ltd_movies_flutter/features/domain/usecases/get_popular_movies.dart';

import '../../../fixtures/mocks.dart';
import '../../../fixtures/movie_fixtures.dart';

void main() {
  late GetPopularMovies useCase;
  late MockMoviesRepository mockRepository;

  setUp(() {
    mockRepository = MockMoviesRepository();
    useCase = GetPopularMovies(mockRepository);
  });

  group('GetPopularMovies', () {
    const testPage = 1;
    const testTotalPages = 10;

    test('should get popular movies from repository', () async {
      when(() => mockRepository.getPopularMovies(testPage))
          .thenAnswer((_) async => (MovieFixtures.testMovies, testTotalPages));

      final result = await useCase(testPage);

      expect(result.$1, MovieFixtures.testMovies);
      expect(result.$2, testTotalPages);
      verify(() => mockRepository.getPopularMovies(testPage)).called(1);
    });

    test('should pass page parameter correctly', () async {
      const page = 5;
      when(() => mockRepository.getPopularMovies(page))
          .thenAnswer((_) async => (MovieFixtures.testMovies, testTotalPages));

      await useCase(page);

      verify(() => mockRepository.getPopularMovies(page)).called(1);
    });

    test('should return empty list when repository returns empty', () async {
      when(() => mockRepository.getPopularMovies(testPage))
          .thenAnswer((_) async => (<Movie>[], 0));

      final result = await useCase(testPage);

      expect(result.$1, isEmpty);
      expect(result.$2, 0);
    });

    test('should propagate exception from repository', () async {
      when(() => mockRepository.getPopularMovies(testPage))
          .thenThrow(Exception('Repository error'));

      expect(() => useCase(testPage), throwsA(isA<Exception>()));
    });
  });
}


