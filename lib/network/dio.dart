import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'auth.dart';

class DioFactory {
  static Dio create(Interceptors interceptors) {
    final dio = Dio()..interceptors.addAll(interceptors);
    return dio;
  }

  static Dio withDefaultInterceptors({@required AuthDataDelegate authDataDelegate}) {
    return create(getDefaultInterceptors(authDataDelegate: authDataDelegate));
  }

  static Interceptors getDefaultInterceptors({@required AuthDataDelegate authDataDelegate}) {
    return Interceptors()
      ..addAll([
        LogInterceptor(requestBody: true, responseBody: true),
        AuthInterceptor(authDataDelegate: authDataDelegate),
      ]);
  }
}
