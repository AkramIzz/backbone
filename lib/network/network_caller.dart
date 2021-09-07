import 'dart:async';

import 'package:backbone/utils/or_error.dart';

typedef ErrorReporterCallback = void Function(dynamic exception, StackTrace st);

// common network errors
enum NetworkErrorType {
  unknown,
  timeout,
}

class NetworkError implements Exception {
  final String message;
  final NetworkErrorType type;

  NetworkError.unknown([this.message]) : type = NetworkErrorType.unknown;
  NetworkError.timeout([this.message]) : type = NetworkErrorType.timeout;

  @override
  String toString() {
    return "$runtimeType($type) ${message == null ? '' : ': $message'}";
  }
}

/// usage:
///
/// in Bloc
/// ```
/// final network = serviceLocator.get<NetworkCaller>();
/// final auth = serviceLocator.get<AuthRepository>();
/// ```
/// in Event
/// ```
/// final result = await bloc.network.call(() => bloc.auth.signIn());
/// ```
/// or alternatively if the network call returns a stream
/// ```
/// final stream = await bloc.network.stream(() => bloc.auth.userStatus());
/// ```
/// which would transform all errors into data events of type OrError.error
///
/// this is used so that exceptions don't leak to application layer
/// and to have a indirection level between repositories and BLoCs for logging
/// and other operations.
class NetworkCaller {
  final List<ErrorReporterCallback> _errorReporters = [];

  NetworkCaller();

  final _netwrokErrorsController = StreamController<NetworkError>.broadcast();

  StreamSubscription<NetworkError> listen(
      void Function(NetworkError error) onData) {
    return _netwrokErrorsController.stream.listen(onData);
  }

  Future<OrError<T, E>> call<T, E>(
    Future<OrError<T, E>> delegate(), {
    void cleanUp(),
  }) async {
    ArgumentError.checkNotNull(delegate);

    OrError<T, E> response;
    try {
      response = await delegate();
    } on NetworkError catch (e) {
      _netwrokErrorsController.add(e);
      return OrError.error(null);
    } catch (e, stacktrace) {
      _logError(e, stacktrace);
      return OrError.error(null);
    } finally {
      cleanUp?.call();
    }

    return response;
  }

  Stream<OrError<T, E>> stream<T, E>(
    Stream<OrError<T, E>> delegate(), {
    bool cancelOnError,
  }) {
    try {
      return delegate().transform(StreamTransformer.fromHandlers(
        handleError: (e, st, sink) {
          _logError(e, st);
          sink.add(OrError.error(null));
        },
      ));
    } catch (e) {
      _logError(e);
      return Stream.error(OrError.error(null));
    }
  }

  void _logError<E>(E e, [StackTrace stacktrace]) {
    _errorReporters.forEach((reporter) => reporter(e, stacktrace));
    print('');
    print('=============== UNCAUGHT DATA ERROR ===============');
    print(e);
    if (stacktrace != null) {
      print(stacktrace);
    }
    print('=============== UNCAUGHT DATA ERROR ===============');
    print('');
  }

  addErrorReporter(void Function(dynamic, StackTrace) reporter) {
    _errorReporters.add(reporter);
  }
}
