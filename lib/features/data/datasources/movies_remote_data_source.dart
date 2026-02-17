import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/api_service.dart';
import 'package:sys_ltd_movies_flutter/core/services/localization/localization_service.dart';
import 'package:sys_ltd_movies_flutter/core/utils/end_points.dart';
import 'package:sys_ltd_movies_flutter/features/data/models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<(List<MovieModel>, int)> getPopularMovies(int page);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final ApiService _apiService;
  final LocalizationService _localizationService;

  const MoviesRemoteDataSourceImpl(
    this._apiService,
    this._localizationService,
  );

  @override
  Future<(List<MovieModel>, int)> getPopularMovies(int page) async {
    try {
      final response = await _apiService.get(
        endPoint: EndPoints.popularMoviesPath,
        query: {
          'api_key': EndPoints.apiKey,
          'language': _localizationService.getCurrentLanguageWithCountry(),
          'page': page,
        },
      );
      final results = (response['results'] as List)
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      final totalPages = response['total_pages'] as int? ?? 1;
      return (results, totalPages);
    } catch (exception) {
      throw ServerException.fromException(exception);
    }
  }
}
