import 'package:botanic_visit_guide/features/zone_finder/data/datasources/zone_finder_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/repositories/zone_finder_repository_impl.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/repositories/zone_finder_repository.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_zone_data.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/geolocator_wrapper.dart';
import 'core/services/gps_service.dart';
import 'features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'features/zone_creator/data/repositories/zone_repository_impl.dart';
import 'features/zone_creator/domain/repositories/zone_repository.dart';
import 'features/zone_creator/domain/usecases/add_zone.dart';
import 'features/zone_creator/domain/usecases/get_all_zones.dart';
import 'features/zone_creator/presentation/bloc/bloc.dart';
import 'features/zone_finder/domain/usecases/get_all_zones_data.dart';
import 'features/zone_finder/presentation/bloc/zone_finder_bloc.dart';

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

  //! Features - Zone Finder
  // Bloc
  sl.registerFactory(() => ZoneFinderBloc(
        getAllZonesData: sl(),
        getZoneData: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetAllZonesData(sl()));
  sl.registerLazySingleton(() => GetZoneData(sl()));

  // Repository
  sl.registerLazySingleton<ZoneFinderRepository>(() => ZoneFinderRepositoryImpl(
        localDataSource: sl(),
        //networkInfo: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<ZoneFinderLocalDataSource>(
      () => ZoneFinderLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GpsService>(() => GpsServiceImpl(geolocator: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => GeolocatorWrapper());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
