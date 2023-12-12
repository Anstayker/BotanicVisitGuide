import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/datasources/zone_finder_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/repositories/zone_finder_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockZoneFinderLocalDataSource extends Mock
    implements ZoneFinderLocalDataSource {}

void main() {
  late MockZoneFinderLocalDataSource mockLocalDataSource;
  late ZoneFinderRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockZoneFinderLocalDataSource();
    repository = ZoneFinderRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('getAllZonesData', () {
    // const tWaypoints = WaypointDataModel(
    //     waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
    // final tZoneDataModel = ZoneDataModel(
    //     zoneId: 'zoneId',
    //     name: 'name',
    //     waypoints: [tWaypoints],
    //     description: '');
    // final tZoneDataModelList = [tZoneDataModel, tZoneDataModel];
    // final tZoneDataList = tZoneDataModelList
    //     .map((model) => const ZoneData(
    //         zoneId: 'zoneId',
    //         zoneName: 'name',
    //         waypoints: [
    //           WaypointData(
    //               waypointId: 'waypointId', latitude: 1.0, longitude: 1.0)
    //         ],
    //         zoneDescription: ''))
    //     .toList();

    // TODO: Fix this test
    // test(
    //     'should return list of ZoneData when call to local data source is successful',
    //     () async {
    //   when(() => mockLocalDataSource.getAllZones())
    //       .thenAnswer((_) async => tZoneDataModelList);

    //   final result = await repository.getAllZonesData();

    //   verify(() => mockLocalDataSource.getAllZones());
    //   expect(result, equals(Right<Failure, List<ZoneData>>(tZoneDataList)));
    // });

    test(
        'should return CacheFailure when call to local data source is unsuccessful',
        () async {
      when(() => mockLocalDataSource.getAllZones()).thenThrow(CacheException());

      final result = await repository.getAllZonesData();

      verify(() => mockLocalDataSource.getAllZones());
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('getZoneData', () {
    const tZoneId = 'zoneId';
    // const tWaypoints = WaypointDataModel(
    //     waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
    // final tZoneDataModel = ZoneDataModel(
    //     zoneId: 'zoneId',
    //     name: 'name',
    //     waypoints: [tWaypoints],
    //     description: '');
    // const tWaypointData =
    //     WaypointData(waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
    // const tZoneData = ZoneData(
    //     zoneId: 'zoneId',
    //     zoneName: 'name',
    //     zoneDescription: '',
    //     waypoints: [tWaypointData]);

    // TODO Fix this test
    // test('should return ZoneData when call to local data source is successful',
    //     () async {
    //   when(() => mockLocalDataSource.getZoneData(any()))
    //       .thenAnswer((_) async => tZoneDataModel);

    //   final result = await repository.getZoneData(tZoneId);

    //   verify(() => mockLocalDataSource.getZoneData(tZoneId));
    //   expect(result, equals(Right(tZoneData)));
    // });

    test(
        'should return CacheFailure when call to local data source is unsuccessful',
        () async {
      when(() => mockLocalDataSource.getZoneData(any()))
          .thenThrow(CacheException());

      final result = await repository.getZoneData(tZoneId);

      verify(() => mockLocalDataSource.getZoneData(tZoneId));
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
