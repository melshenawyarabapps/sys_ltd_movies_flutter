import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/features/data/datasources/movies_remote_data_source.dart';

import '../../../fixtures/mocks.dart';
import '../../../fixtures/movie_fixtures.dart';

void main() {
  late MoviesRemoteDataSourceImpl dataSource;
  late MockApiService mockApiService;
  late MockLocalizationService mockLocalizationService;

  setUp(() {
    mockApiService = MockApiService();
    mockLocalizationService = MockLocalizationService();
    dataSource = MoviesRemoteDataSourceImpl(
      mockApiService,
      mockLocalizationService,
    );

    when(() => mockLocalizationService.getCurrentLanguageWithCountry())
        .thenReturn('en-US');
  });

  group('MoviesRemoteDataSource', () {
    group('getPopularMovies', () {
      const testPage = 1;

      test('should return list of MovieModel and total pages on success',
          () async {
        when(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).thenAnswer((_) async => MovieFixtures.testApiResponse);

        final result = await dataSource.getPopularMovies(testPage);

        expect(result.$1.length, 3);
        expect(result.$2, 10);
        expect(result.$1.first.id, 1);
        expect(result.$1.first.title, 'Test Movie 1');
        verify(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).called(1);
      });

      test('should use device language from localization service', () async {
        when(() => mockLocalizationService.getCurrentLanguageWithCountry())
            .thenReturn('ar-EG');
        when(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).thenAnswer((_) async => MovieFixtures.testApiResponse);

        await dataSource.getPopularMovies(testPage);

        verify(() => mockLocalizationService.getCurrentLanguageWithCountry())
            .called(1);
      });

      test('should throw ServerException when API call fails', () async {
        when(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).thenThrow(Exception('Network error'));

        expect(
          () => dataSource.getPopularMovies(testPage),
          throwsA(isA<ServerException>()),
        );
      });

      test('should handle empty results gracefully', () async {
        when(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).thenAnswer((_) async => {
              'results': [],
              'total_pages': 0,
            });

        final result = await dataSource.getPopularMovies(testPage);

        expect(result.$1, isEmpty);
        expect(result.$2, 0);
      });

      test('should handle null total_pages with default value', () async {
        when(
          () => mockApiService.get(
            endPoint: any(named: 'endPoint'),
            query: any(named: 'query'),
          ),
        ).thenAnswer((_) async => {
              'results': [],
              'total_pages': null,
            });

        final result = await dataSource.getPopularMovies(testPage);

        expect(result.$2, 1);
      });
    });
  });
}


