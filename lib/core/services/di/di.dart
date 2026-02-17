import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/api_service.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/network_info.dart';
import 'package:sys_ltd_movies_flutter/core/services/localization/localization_service.dart';
import 'package:sys_ltd_movies_flutter/features/data/datasources/movies_remote_data_source.dart';
import 'package:sys_ltd_movies_flutter/features/data/repositories/movies_repository_impl.dart';
import 'package:sys_ltd_movies_flutter/features/domain/repositories/movies_repository.dart';

GetIt getIt = GetIt.instance;

void setUp() {
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<LocalizationService>(
    () => const LocalizationServiceImpl(),
  );
  getIt.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(
      getIt<ApiService>(),
      getIt<LocalizationService>(),
    ),
  );
  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      getIt.get<MoviesRemoteDataSource>(),
      getIt.get<NetworkInfo>(),
    ),
  );
}
