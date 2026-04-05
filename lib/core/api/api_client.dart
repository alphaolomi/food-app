import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../session_bridge.dart';
import 'api_exception.dart';
import 'token_storage.dart';

typedef UnauthorizedCallback = Future<void> Function();

class ApiClient {
  ApiClient({
    required TokenStorage tokenStorage,
    UnauthorizedCallback? onUnauthorized,
    Dio? dio,
  })  : _tokenStorage = tokenStorage,
        _onUnauthorized = onUnauthorized ?? SessionBridge.trigger,
        _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConfig.baseUrl,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
                headers: {
                  Headers.acceptHeader: 'application/json',
                  Headers.contentTypeHeader: 'application/json',
                },
              ),
            ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _tokenStorage.clear();
            await _onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  final TokenStorage _tokenStorage;
  final UnauthorizedCallback? _onUnauthorized;
  final Dio _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _wrap(() => _dio.get<T>(path, queryParameters: queryParameters, options: options));
  }

  Future<Response<T>> post<T>(String path, {Object? data, Map<String, dynamic>? queryParameters, Options? options}) {
    return _wrap(() => _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options));
  }

  Future<Response<T>> delete<T>(String path, {Object? data, Options? options}) {
    return _wrap(() => _dio.delete<T>(path, data: data, options: options));
  }

  Future<Response<T>> _wrap<T>(Future<Response<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  ApiException _mapDio(DioException e) {
    final response = e.response;
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'] as String? ?? e.message ?? 'Request failed';
      final code = data['code'] as String?;
      Map<String, List<String>>? fieldErrors;
      final rawErrors = data['errors'];
      if (rawErrors is Map) {
        fieldErrors = rawErrors.map(
          (k, v) => MapEntry(
            k.toString(),
            (v is List) ? v.map((e) => e.toString()).toList() : [v.toString()],
          ),
        );
      }
      return ApiException(message, code: code, statusCode: response?.statusCode, fieldErrors: fieldErrors);
    }
    return ApiException(e.message ?? 'Network error', statusCode: response?.statusCode);
  }
}
