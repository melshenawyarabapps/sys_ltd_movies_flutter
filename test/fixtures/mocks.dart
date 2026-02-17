import 'package:mocktail/mocktail.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/api_service.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/network_info.dart';
import 'package:sys_ltd_movies_flutter/core/services/localization/localization_service.dart';
import 'package:sys_ltd_movies_flutter/features/data/datasources/movies_remote_data_source.dart';
import 'package:sys_ltd_movies_flutter/features/domain/repositories/movies_repository.dart';
import 'package:sys_ltd_movies_flutter/features/domain/usecases/get_popular_movies.dart';

class MockApiService extends Mock implements ApiService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalizationService extends Mock implements LocalizationService {}

class MockMoviesRemoteDataSource extends Mock implements MoviesRemoteDataSource {}

class MockMoviesRepository extends Mock implements MoviesRepository {}

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

