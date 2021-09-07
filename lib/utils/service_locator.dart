import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:backbone/network/api.dart';
import 'package:backbone/network/dio.dart';
import 'package:backbone/network/network_caller.dart';
import 'package:backbone/utils/persistence_manager.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  final persistenceManager = PersistenceManager()..init();
  serviceLocator.registerSingleton<PersistenceManager>(persistenceManager);
  serviceLocator.registerSingleton<SettingsStorage>(persistenceManager);
  serviceLocator.registerSingleton<UserStorage>(persistenceManager);
  serviceLocator.registerSingleton<Dio>(DioFactory.withDefaultInterceptors());
  serviceLocator.registerFactory<Api>(() => Api(serviceLocator.get<Dio>()));
  serviceLocator.registerSingleton<NetworkCaller>(NetworkCaller());
}