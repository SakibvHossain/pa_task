import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pa_task/core/network/network_exceptions.dart';
import 'package:pa_task/core/network/network_request.dart';
import 'mocks.mocks.dart';


void main() {
  late MockDio mockDio;
  late NetworkRequest networkRequest;

  setUp(() {
    mockDio = MockDio();
    networkRequest = NetworkRequest(mockDio);
  });

  group('NetworkRequest GET', () {
    const path = '/test';

    test('returns response on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: {'key': 'value'},
      );

      when(mockDio.get<dynamic>(
        path,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => response);

      final result = await networkRequest.get(path);

      expect(result.data, {'key': 'value'});
      verify(mockDio.get(path)).called(1);
    });

    test('throws NoInternetException on connection error', () async {
      when(mockDio.get<dynamic>(
        path,
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: path),
        ),
      );

      expect(
            () => networkRequest.get(path),
        throwsA(isA<NoInternetException>()),
      );
    });

    test('throws TimeoutException on timeout', () async {
      when(mockDio.get<dynamic>(
        path,
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: path),
        ),
      );

      expect(
            () => networkRequest.get(path),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('throws ClientException on 4xx error', () async {
      when(mockDio.get<dynamic>(
        path,
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: path),
            data: 'Not found',
          ),
          requestOptions: RequestOptions(path: path),
        ),
      );

      expect(
            () => networkRequest.get(path),
        throwsA(isA<ClientException>()),
      );
    });

    test('throws ServerException on 5xx error', () async {
      when(mockDio.get<dynamic>(
        path,
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: path),
          ),
          requestOptions: RequestOptions(path: path),
        ),
      );

      expect(
            () => networkRequest.get(path),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
