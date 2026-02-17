
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<(List<Movie>, int)> getPopularMovies(int page);
}
