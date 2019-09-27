import 'package:dio/dio.dart';

class DioFactory {
  static Dio create() {
    final dio = Dio();
    addInterceptors(dio);
    return dio;
  }

  static void addInterceptors(Dio dio) {
    dio.interceptors.add(LogInterceptor());
  }
}