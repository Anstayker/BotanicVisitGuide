import 'package:botanic_visit_guide/core/services/geolocator_wrapper.dart';
import 'package:botanic_visit_guide/core/services/gps_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'features/zone_creator/data/repositories/zone_repository_impl.dart';
import 'features/zone_creator/domain/repositories/zone_repository.dart';
import 'features/zone_creator/domain/usecases/add_zone.dart';
import 'features/zone_creator/domain/usecases/get_all_zones.dart';
import 'features/zone_creator/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Zone Creator
  // Bloc
  sl.registerFactory(
    () => ZoneCreatorBloc(
      addZone: sl(),
      getAllZones: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAllZones(sl()));
  sl.registerLazySingleton(() => AddZone(sl()));

  // Repository
  sl.registerLazySingleton<ZoneRepository>(
    () => ZoneRepositoryImpl(
      localDataSource: sl(),
      //networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ZoneCreatorLocalDataSource>(
    () => ZoneCreatorLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GpsService>(() => GpsServiceImpl(geolocator: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => GeolocatorWrapper());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
