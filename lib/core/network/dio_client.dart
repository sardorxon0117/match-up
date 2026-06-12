import 'package:dio/dio.dart';
import 'package:matchup/core/app_constants/constants.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'x-apisports-key': AppConstants.xApisportsKey,
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(request: true, responseBody: true, error: true),
    );

    return dio;
  }
}

