import 'package:dio/dio.dart';
import '../config/env.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/unauthorized_interceptor.dart';

class DioProvider {
  DioProvider._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _build();
    return _instance!;
  }

  static Dio _build() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      UnauthorizedInterceptor(),
    ]);

    return dio;
  }
}
