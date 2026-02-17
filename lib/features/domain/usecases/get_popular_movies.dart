import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';
import 'package:sys_ltd_movies_flutter/features/domain/repositories/movies_repository.dart';

class GetPopularMovies {
  final MoviesRepository repository;

  const GetPopularMovies(this.repository);

  Future<(List<Movie>, int)> call(int page) {
    return repository.getPopularMovies(page);
  }
}
