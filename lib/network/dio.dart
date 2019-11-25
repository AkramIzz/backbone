import 'package:dio/dio.dart';

import 'auth.dart';

class DioFactory {
  static Dio create(Interceptors interceptors) {
    final dio = Dio()..interceptors.addAll(interceptors);
    return dio;
  }

  static Dio withDefaultInterceptors() {
    return create(getDefaultInterceptors());
  }

  static Interceptors getDefaultInterceptors() {
    return Interceptors()
      ..addAll([
        LogInterceptor(requestBody: true, responseBody: true),
        AuthInterceptor(),
      ]);
  }
}
