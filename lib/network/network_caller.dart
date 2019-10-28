import 'dart:async';

import 'package:dio/dio.dart';
import 'package:backbone/utils/or_error.dart';

import 'api.dart';

class NetworkCallError {
  DioError e;

  NetworkCallError(this.e);
}

class NetworkCaller {
  final Api client;

  NetworkCaller(this.client);

  Future<OrError<T, NetworkCallError>> call<T>(
    Future<T> delegate(Api client), {
    void before(Api client),
    void after(Api client),
  }) async {
    ArgumentError.checkNotNull(delegate);

    before?.call(client);

    T response;
    try {
      response = await delegate(client);
    } on DioError catch (e) {
      _logError(e);
      return OrError.error(NetworkCallError(e));
    } catch (e, stacktrace) {
      _logError(e, stacktrace);
      return OrError.error(NetworkCallError(null));
    }

    after?.call(client);

    return OrError.value(response);
  }

  void _logError<E>(E e, [StackTrace stacktrace]) {
    print('');
    print('=============== ERROR ===============');
    print(e);
    if (stacktrace != null) {
      print(stacktrace);
    }
    print('=============== ERROR ===============');
    print('');
  }
}
