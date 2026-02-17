import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/network_info.dart';
import 'package:sys_ltd_movies_flutter/features/data/datasources/movies_remote_data_source.dart';
import 'package:sys_ltd_movies_flutter/features/data/models/movie_model.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';
import 'package:sys_ltd_movies_flutter/features/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  MoviesRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<(List<Movie>, int)> getPopularMovies(int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.getPopularMovies(page);
        return (result.$1.map((movie) => movie.toEntity).toList(), result.$2);
      } catch (exception) {
        rethrow;
      }
    } else {
      throw const NoInternetException();
    }
  }
}
