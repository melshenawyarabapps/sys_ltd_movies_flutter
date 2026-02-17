import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/services/logger/app_logger.dart';

class BlocLifecycleObserver extends BlocObserver {

  BlocLifecycleObserver._();
  static BlocLifecycleObserver? _instance;
  static BlocLifecycleObserver get instance => _instance ??= BlocLifecycleObserver._();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.instance.info('onCreate ===> ${bloc.runtimeType} \n');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.instance.info(
      'onChange ===> ${bloc.runtimeType} ====> \n ${change.toString()} \n',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.instance.error(
      'onError ===> ${bloc.runtimeType}',
      error,
      stackTrace,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.instance.info('onClose ===> ${bloc.runtimeType} \n');
  }
}
