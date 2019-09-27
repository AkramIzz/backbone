import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';

class NetworkCallError {
  DioError e;

  NetworkCallError(this.e);
}

class NetworkCaller<T> {
  void Function(Api client) _before;
  void Function(T response) _after;
  Future<T> Function(Api client) _call;
  void Function(NetworkCallError error) _onError;

  final Api client;

  NetworkCaller(this.client);

  Future<void> exec() async {
    ArgumentError.checkNotNull(call);
    ArgumentError.checkNotNull(onError);
    
    _before?.call(client);
    T response;
    try {
      response = await _call(client);
    } on DioError catch(e) {
      _onError(NetworkCallError(e));
    } finally {
      _after?.call(response);
    }
  }

  void call(Future<T> callback(Api client)) {
    _call = callback;
  }

  void before(void callback(Api client)) {
    _before = callback;
  }

  void after(void callback(T response)) {
    _after = callback;
  }

  void onError(void callback(NetworkCallError error)) {
    _onError = callback;
  }

  void networkCall({
    void before(Api client),
    @required Future<T> call(Api client),
    void after(T response),
    @required void onError(NetworkCallError error)
  }) async {
    _before = before;
    _call = call;
    _after = after;
    _onError = onError;
    await exec();
  }
}