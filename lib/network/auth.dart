import 'package:dio/dio.dart';

abstract class AuthDataDelegate {
  bool get isLoggedIn;
  String get accessToken;
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor({this.authDataDelegate});

  final AuthDataDelegate authDataDelegate;

  @override
  onRequest(Options options) {
    if (authDataDelegate.isLoggedIn && authDataDelegate.accessToken != null) {
      options.headers['Authorization'] = authDataDelegate.accessToken;
    }
    return options;
  }
}
