import 'package:dio/dio.dart';
import 'network_exceptions.dart';

class NetworkRequest {
  final Dio _dio;

  NetworkRequest(this._dio);

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? query,
      }) {
    return _safeRequest(
          () => _dio.get<T>(path, queryParameters: query),
    );
  }

  Future<Response<T>> post<T>(
      String path, {
        dynamic body,
        Map<String, dynamic>? query,
      }) {
    return _safeRequest(
          () => _dio.post<T>(path, data: body, queryParameters: query),
    );
  }

  Future<Response<T>> put<T>(
      String path, {
        dynamic body,
        Map<String, dynamic>? query,
      }) {
    return _safeRequest(
          () => _dio.put<T>(path, data: body, queryParameters: query),
    );
  }

  Future<Response<T>> delete<T>(
      String path, {
        Map<String, dynamic>? query,
      }) {
    return _safeRequest(
          () => _dio.delete<T>(path, queryParameters: query),
    );
  }

  Future<Response<T>> _safeRequest<T>(
      Future<Response<T>> Function() request,
      ) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _mapException(e);
    }
  }

  NetworkException _mapException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NoInternetException();

      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        if (status >= 400 && status < 500) {
          return ClientException(
            e.response?.data.toString() ?? 'Client error',
          );
        }
        if (status >= 500) {
          return const ServerException();
        }
        return const UnknownNetworkException();

      default:
        return const UnknownNetworkException();
    }
  }
}
