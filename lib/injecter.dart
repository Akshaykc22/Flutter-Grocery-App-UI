import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/data/local/data_source/auth_local_datasource.dart';
import 'package:grocery_app/data/remote/data_source/auth_data_source.dart';
import 'package:grocery_app/data/repository/auth_data_repository_impl.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/connection_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data source
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()));

  //repository
  sl.registerLazySingleton<AuthDataRepository>(
      () => AuthDataRepositoryImpl(sl()));
  await GetStorage.init();
  // sl.registerSingleton(NavigationBarMoksha(sl()));
  sl.registerLazySingleton<ConnectionInfo>(() => ConnectionInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => GetStorage());
}
