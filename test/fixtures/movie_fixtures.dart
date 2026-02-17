import 'package:sys_ltd_movies_flutter/features/data/models/movie_model.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

class MovieFixtures {
  MovieFixtures._();

  static const testMovieJson = {
    'id': 1,
    'title': 'Test Movie',
    'overview': 'Test overview description',
    'poster_path': '/test_poster.jpg',
  };

  static const testMovieJsonList = [
    {
      'id': 1,
      'title': 'Test Movie 1',
      'overview': 'Test overview 1',
      'poster_path': '/poster1.jpg',
    },
    {
      'id': 2,
      'title': 'Test Movie 2',
      'overview': 'Test overview 2',
      'poster_path': '/poster2.jpg',
    },
    {
      'id': 3,
      'title': 'Test Movie 3',
      'overview': 'Test overview 3',
      'poster_path': null,
    },
  ];

  static const testApiResponse = {
    'page': 1,
    'results': testMovieJsonList,
    'total_pages': 10,
    'total_results': 200,
  };

  static const testApiResponsePage2 = {
    'page': 2,
    'results': [
      {
        'id': 4,
        'title': 'Test Movie 4',
        'overview': 'Test overview 4',
        'poster_path': '/poster4.jpg',
      },
    ],
    'total_pages': 10,
    'total_results': 200,
  };

  static const testMovieModel = MovieModel(
    id: 1,
    title: 'Test Movie',
    overview: 'Test overview description',
    posterPath: '/test_poster.jpg',
  );

  static const testMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'Test overview description',
    posterPath: '/test_poster.jpg',
  );

  static List<MovieModel> get testMovieModels => [
        const MovieModel(
          id: 1,
          title: 'Test Movie 1',
          overview: 'Test overview 1',
          posterPath: '/poster1.jpg',
        ),
        const MovieModel(
          id: 2,
          title: 'Test Movie 2',
          overview: 'Test overview 2',
          posterPath: '/poster2.jpg',
        ),
        const MovieModel(
          id: 3,
          title: 'Test Movie 3',
          overview: 'Test overview 3',
          posterPath: null,
        ),
      ];

  static List<Movie> get testMovies => [
        const Movie(
          id: 1,
          title: 'Test Movie 1',
          overview: 'Test overview 1',
          posterPath: '/poster1.jpg',
        ),
        const Movie(
          id: 2,
          title: 'Test Movie 2',
          overview: 'Test overview 2',
          posterPath: '/poster2.jpg',
        ),
        const Movie(
          id: 3,
          title: 'Test Movie 3',
          overview: 'Test overview 3',
          posterPath: null,
        ),
      ];

  static List<Movie> get testMoviesPage2 => [
        const Movie(
          id: 4,
          title: 'Test Movie 4',
          overview: 'Test overview 4',
          posterPath: '/poster4.jpg',
        ),
      ];
}

