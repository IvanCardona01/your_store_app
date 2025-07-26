import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {

  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: Implement auth token provider
    final token = '';
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
