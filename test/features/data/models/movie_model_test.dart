import 'package:flutter_test/flutter_test.dart';
import 'package:sys_ltd_movies_flutter/features/data/models/movie_model.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

import '../../../fixtures/movie_fixtures.dart';

void main() {
  group('MovieModel', () {
    group('fromJson', () {
      test('should create MovieModel from valid JSON', () {
        final result = MovieModel.fromJson(MovieFixtures.testMovieJson);

        expect(result.id, 1);
        expect(result.title, 'Test Movie');
        expect(result.overview, 'Test overview description');
        expect(result.posterPath, '/test_poster.jpg');
      });

      test('should handle null poster_path', () {
        final jsonWithNullPoster = {
          'id': 1,
          'title': 'Test Movie',
          'overview': 'Test overview',
          'poster_path': null,
        };

        final result = MovieModel.fromJson(jsonWithNullPoster);

        expect(result.posterPath, isNull);
      });

      test('should handle missing title with empty string', () {
        final jsonWithoutTitle = {
          'id': 1,
          'overview': 'Test overview',
          'poster_path': '/poster.jpg',
        };

        final result = MovieModel.fromJson(jsonWithoutTitle);

        expect(result.title, '');
      });

      test('should handle missing overview with empty string', () {
        final jsonWithoutOverview = {
          'id': 1,
          'title': 'Test Movie',
          'poster_path': '/poster.jpg',
        };

        final result = MovieModel.fromJson(jsonWithoutOverview);

        expect(result.overview, '');
      });
    });

    group('toEntity', () {
      test('should convert MovieModel to Movie entity', () {
        const model = MovieModel(
          id: 1,
          title: 'Test Movie',
          overview: 'Test overview',
          posterPath: '/poster.jpg',
        );

        final entity = model.toEntity;

        expect(entity, isA<Movie>());
        expect(entity.id, model.id);
        expect(entity.title, model.title);
        expect(entity.overview, model.overview);
        expect(entity.posterPath, model.posterPath);
      });

      test('should preserve null posterPath when converting to entity', () {
        const model = MovieModel(
          id: 1,
          title: 'Test Movie',
          overview: 'Test overview',
          posterPath: null,
        );

        final entity = model.toEntity;

        expect(entity.posterPath, isNull);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        const model1 = MovieModel(
          id: 1,
          title: 'Test',
          overview: 'Overview',
          posterPath: '/path.jpg',
        );
        const model2 = MovieModel(
          id: 1,
          title: 'Test',
          overview: 'Overview',
          posterPath: '/path.jpg',
        );

        expect(model1, equals(model2));
      });

      test('should not be equal when id is different', () {
        const model1 = MovieModel(
          id: 1,
          title: 'Test',
          overview: 'Overview',
          posterPath: '/path.jpg',
        );
        const model2 = MovieModel(
          id: 2,
          title: 'Test',
          overview: 'Overview',
          posterPath: '/path.jpg',
        );

        expect(model1, isNot(equals(model2)));
      });
    });
  });
}


