import 'dart:async';

import 'package:dio/dio.dart';

import 'api.dart';

class NetworkCallError {
  DioError e;

  NetworkCallError(this.e);
}

class NetworkCaller {
  final Api client;

  NetworkCaller(this.client);

  Future<T> call<T>(
    Future<T> call(Api client), {
    void onError(NetworkCallError e),
    void before(Api client),
    void after(Api client),
  }) async {
    ArgumentError.checkNotNull(call);

    before?.call(client);
    T response;
    try {
      response = await call(client);
    } on DioError catch (e) {
      print('');
      print('=============== ERROR ===============');
      print(e);
      print('=============== ERROR ===============');
      print('');
      onError?.call(NetworkCallError(e));
    } catch (e, stacktrace) {
      print('');
      print('=============== ERROR ===============');
      print(e);
      print(stacktrace);
      print('=============== ERROR ===============');
      print('');
      onError(NetworkCallError(null));
    } finally {
      after?.call(client);
    }
    // TODO: return either T or Error
    return response;
  }
}
