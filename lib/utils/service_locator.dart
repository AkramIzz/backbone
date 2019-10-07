import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mwaslat/network/auth.dart';
import 'package:mwaslat/utils/persistence_manager.dart';

import '../network/api.dart';
import '../network/dio.dart';
import '../network/network_caller.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<PersistenceManager>(PersistenceManager());
  AuthDataDelegate delegate = serviceLocator.get<PersistenceManager>();
  serviceLocator.registerSingleton<Dio>(DioFactory.withDefaultInterceptors(authDataDelegate: delegate));
  // serviceLocator.registerFactory<Api>(() => Api(serviceLocator.get<Dio>()));
  serviceLocator.registerFactory<Api>(() => MockedApi());
  serviceLocator.registerFactory<NetworkCaller>(() => NetworkCaller(serviceLocator.get<Api>()));
}