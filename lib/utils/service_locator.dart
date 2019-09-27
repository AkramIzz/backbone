import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api.dart';
import '../network/dio.dart';
import '../network/network_caller.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<Dio>(DioFactory.create());
  serviceLocator.registerFactory<Api>(() => Api(serviceLocator.get<Dio>()));
  serviceLocator.registerFactory<NetworkCaller>(() => NetworkCaller(serviceLocator.get<Api>()));
}