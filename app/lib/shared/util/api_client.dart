import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'secure_storage.dart';
import 'shared_prefs_provider.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  // Dynamic Base URL fallback
  final apiBaseUrl =
      prefs.getString('api_base_url') ?? 'https://us-central1-m3tal-project.cloudfunctions.net/api';

  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl.startsWith('http')
          ? apiBaseUrl
          : 'http://$apiBaseUrl',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-org-id': 'default-org',
      },
    ),
  );

  // 1. Auth Interceptor for adding JWT header
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.readToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) {
        if (e.response?.statusCode == 401) {
          debugPrint('[ApiClient] Unauthorized error (401). Invalid token.');
          // Session could be cleared here if needed
        }
        return handler.next(e);
      },
    ),
  );

  // 2. Custom retry interceptor for network/timeout errors
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      maxRetries: 3,
      delay: const Duration(seconds: 2),
    ),
  );

  // 3. Logger Interceptor for development
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  return dio;
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration delay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.delay = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // Check if error is a connection error and request should be retried
    final isConnectionError =
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;

    // Get current retry count
    var retryCount = requestOptions.extra['retry_count'] as int? ?? 0;

    if (isConnectionError && retryCount < maxRetries) {
      retryCount++;
      requestOptions.extra['retry_count'] = retryCount;
      debugPrint(
        '[ApiClient] Network error. Retrying request ($retryCount/$maxRetries) in ${delay.inSeconds}s...',
      );

      await Future.delayed(delay);

      try {
        final response = await dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
            extra: requestOptions.extra,
            responseType: requestOptions.responseType,
            contentType: requestOptions.contentType,
          ),
        );
        return handler.resolve(response);
      } catch (e) {
        // If retry fails, bubble up the error or let it continue to next retry
        if (e is DioException) {
          return super.onError(e, handler);
        }
        return handler.next(
          DioException(requestOptions: requestOptions, error: e),
        );
      }
    }

    return super.onError(err, handler);
  }
}

// Exception wrapper for custom user-friendly error states
class ApiClientException implements Exception {
  final String message;
  final int? statusCode;

  ApiClientException(this.message, {this.statusCode});

  @override
  String toString() => message;

  factory ApiClientException.fromDioError(DioException error) {
    if (error.response != null) {
      final data = error.response?.data;
      if (data is Map && data.containsKey('error')) {
        return ApiClientException(
          data['error'].toString(),
          statusCode: error.response?.statusCode,
        );
      }
      return ApiClientException(
        'Server returned error: ${error.response?.statusMessage}',
        statusCode: error.response?.statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiClientException(
          'Connection timeout. Please check your network.',
        );
      case DioExceptionType.connectionError:
        return ApiClientException(
          'Cannot connect to the server. Please ensure the server is running.',
        );
      default:
        return ApiClientException(
          'An unexpected error occurred. Please try again.',
        );
    }
  }
}
