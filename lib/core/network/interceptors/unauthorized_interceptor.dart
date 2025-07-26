import 'package:dio/dio.dart';

class UnauthorizedInterceptor extends Interceptor {

  UnauthorizedInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //TODO: Implement unauthorized logic (fresh token or redirect to login)
    }
    handler.next(err);
  }
}
