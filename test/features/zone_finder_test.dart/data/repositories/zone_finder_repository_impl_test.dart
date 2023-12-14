import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/core/network/network_info.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/datasources/zone_finder_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/datasources/zone_finder_remote_datasource.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/models/waypoint_data_model.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/repositories/zone_finder_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneFinderLocalDataSource extends Mock
    implements ZoneFinderLocalDataSource {}

class MockZoneFinderRemoteDataSource extends Mock
    implements ZoneFinderRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockZoneFinderLocalDataSource mockLocalDataSource;
  late ZoneFinderRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockZoneFinderRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockZoneFinderLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockZoneFinderRemoteDataSource();
    repository = ZoneFinderRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getAllZonesData', () {
    const tWaypointsData = WaypointDataModel(
        waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
    const tZoneDataModel = ZoneDataModel(
        zoneId: 'zoneId', zoneName: 'zoneName', waypoints: [tWaypointsData]);
    final tZoneList = [tZoneDataModel];

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAllZones())
          .thenAnswer((_) async => tZoneList);
      // act
      repository.getAllZonesData();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    // test(
    //     'should return remote data when the call to remote data source is successful',
    //     () async {
    //   // arrange
    //   when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   when(() => mockRemoteDataSource.getAllZones())
    //       .thenAnswer((_) async => tZoneList);
    //   // act
    //   final result = await repository.getAllZonesData();
    //   final zoneDataList = result.fold((l) => null, (r) => r);
    //   // assert
    //   verify(() => mockRemoteDataSource.getAllZones());
    //   expect(zoneDataList, equals(Right(tZoneInfoList)));
    // });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAllZones())
          .thenThrow(ServerException());
      // act
      final result = await repository.getAllZonesData();
      // assert
      verify(() => mockRemoteDataSource.getAllZones());
      expect(result, equals(Left(ServerFailure())));
    });

    // test(
    //     'should return last locally cached data when the cached data is present',
    //     () async {
    //   // arrange
    //   when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    //   when(() => mockLocalDataSource.getAllZones())
    //       .thenAnswer((_) async => tZoneList);
    //   // act
    //   final result = await repository.getAllZonesData();
    //   // assert
    //   verify(() => mockLocalDataSource.getAllZones());
    //   expect(result, equals(Right(tZoneList)));
    // });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getAllZones()).thenThrow(CacheException());
      // act
      final result = await repository.getAllZonesData();
      // assert
      verify(() => mockLocalDataSource.getAllZones());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
