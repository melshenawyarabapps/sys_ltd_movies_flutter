import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/api_service.dart';
import 'package:sys_ltd_movies_flutter/core/services/api/network_info.dart';

GetIt getIt = GetIt.instance;

void setUp() {
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );
}
