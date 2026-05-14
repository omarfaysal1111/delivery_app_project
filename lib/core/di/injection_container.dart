import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../network/network_info.dart';

// Feature datasources
import '../../features/onboarding/data/datasources/auth_local_datasource.dart';
import '../../features/onboarding/data/datasources/auth_remote_datasource.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/orders/data/datasources/order_local_datasource.dart';
import '../../features/orders/data/datasources/order_remote_datasource.dart';
import '../../features/earnings/data/datasources/earnings_local_datasource.dart';
import '../../features/earnings/data/datasources/earnings_remote_datasource.dart';
import '../../features/navigation_map/data/datasources/map_remote_datasource.dart';
import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient(client: sl()));

  // Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<EarningsRemoteDataSource>(
      () => EarningsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<EarningsLocalDataSource>(
      () => EarningsLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<MapRemoteDataSource>(
      () => MapRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sl()));
}
