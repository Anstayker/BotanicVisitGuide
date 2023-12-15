import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'core/network/network_info.dart';
import 'core/services/geolocator_wrapper.dart';
import 'core/services/gps_service.dart';
import 'features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'features/zone_creator/data/datasources/remote/zone_creator_remote_datasource.dart';
import 'features/zone_creator/data/repositories/zone_repository_impl.dart';
import 'features/zone_creator/domain/repositories/zone_repository.dart';
import 'features/zone_creator/domain/usecases/add_zone.dart';
import 'features/zone_creator/domain/usecases/get_all_zones.dart';
import 'features/zone_creator/presentation/bloc/bloc.dart';
import 'features/zone_finder/data/datasources/zone_finder_local_datasource.dart';
import 'features/zone_finder/data/datasources/zone_finder_remote_datasource.dart';
import 'features/zone_finder/data/repositories/zone_finder_repository_impl.dart';
import 'features/zone_finder/domain/repositories/zone_finder_repository.dart';
import 'features/zone_finder/domain/usecases/get_all_zones_data.dart';
import 'features/zone_finder/domain/usecases/get_zone_data.dart';
import 'features/zone_finder/domain/usecases/get_zone_images.dart';
import 'features/zone_finder/presentation/bloc/zone_finder_bloc.dart';
import 'features/zone_finder/presentation/utils/zone_finder_gps_utils.dart';
import 'firebase_options.dart';

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
      remoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ZoneCreatorLocalDataSource>(
    () => ZoneCreatorLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ZoneCreatorRemoteDatasource>(
      () => ZoneCreatorRemoteDatasourceImpl(firestore: sl(), storage: sl()));

  //! Features - Zone Finder
  // Bloc
  sl.registerFactory(() => ZoneFinderBloc(
        getAllZonesData: sl(),
        getZoneData: sl(),
        gpsUtils: sl(),
        getZoneImages: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetAllZonesData(sl()));
  sl.registerLazySingleton(() => GetZoneData(sl()));
  sl.registerLazySingleton(() => GetZoneImages(sl()));

  // Repository
  sl.registerLazySingleton<ZoneFinderRepository>(() => ZoneFinderRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<ZoneFinderLocalDataSource>(
      () => ZoneFinderLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ZoneFinderRemoteDataSource>(
    () => ZoneFinderRemoteDataSourceImpl(firestore: sl(), storage: sl()),
  );

  // Utils
  sl.registerLazySingleton(() => ZoneFinderGPSUtils());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GpsService>(() => GpsServiceImpl(geolocator: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => GeolocatorWrapper());
  sl.registerLazySingleton(() => const Uuid());
  final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  sl.registerLazySingleton(() => firebase);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
}
