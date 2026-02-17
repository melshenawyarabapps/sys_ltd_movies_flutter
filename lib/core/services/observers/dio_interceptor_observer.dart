
import 'package:dio/dio.dart';
import 'package:sys_ltd_movies_flutter/core/services/logger/app_logger.dart';

class DioInterceptorObserver implements Interceptor {
  DioInterceptorObserver._();

  static DioInterceptorObserver? _instance;
  static DioInterceptorObserver get instance => _instance ??= DioInterceptorObserver._();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.instance.info('📤 [REQUEST] => ${options.method} ${options.uri}');
    AppLogger.instance.debug('🔸 Headers: ${options.headers}');
    AppLogger.instance.debug('🔸 Body: ${options.data}');
    handler.next(options); // forward the request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.instance.info('📥 [RESPONSE] => ${response.statusCode} ${response.requestOptions.uri}');
    AppLogger.instance.debug('🔹 Data: ${response.data}');
    handler.next(response); // forward the response
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final uri = err.requestOptions.uri;
    AppLogger.instance.error('❌ [ERROR] => ${err.response?.statusCode ?? 'Unknown'} $uri');
    AppLogger.instance.debug('🔻 Message: ${err.message}');
    AppLogger.instance.debug('🔻 Error: ${err.error}');
    handler.next(err); // forward the error
  }
}
