import 'package:dio/dio.dart';
import 'package:backbone/utils/persistence_manager.dart';
import 'package:backbone/utils/service_locator.dart';

abstract class AuthDataDelegate {
  bool get isLoggedIn;
  String get accessToken;
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  final user = serviceLocator.get<UserStorage>();

  @override
  onRequest(options) {
    if (user.isLoggedIn && user.accessToken != null) {
      options.headers['Authorization'] = user.accessToken;
    }
    return Future.value(options);
  }
}
