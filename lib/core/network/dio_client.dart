import 'package:dio/dio.dart';
import '../../app/flavors/flavor.dart';
import '../../app/flavors/flavor_config.dart';
import '../constants/api_constants.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.githubBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/vnd.github+json',
        },
      ),
    );

    if (FlavorConfig.flavor == Flavor.dev) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
