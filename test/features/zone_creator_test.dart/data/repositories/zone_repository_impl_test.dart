import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/core/network/network_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/datasources/remote/zone_creator_remote_datasource.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_info_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/repositories/zone_repository_impl.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLocalDataSource extends Mock implements ZoneCreatorLocalDataSource {}

class MockRemoteDataSource extends Mock
    implements ZoneCreatorRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ZoneRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ZoneRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDatasource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getAllZones', () {
    const tWaypoint =
        WaypointInfoModel(waypointId: '1', latitude: 1.0, longitude: 1.0);
    final tZoneModeList = [
      const ZoneInfoModel(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoint])
    ];
    final tZoneInfoList = tZoneModeList
        .map((e) =>
            ZoneInfo(zoneId: e.zoneId, name: e.name, waypoints: e.waypoints))
        .toList();

    test(
      "should get all zones from the remote data source when there is internet connection",
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getAllZones())
            .thenAnswer((_) async => tZoneModeList);
        // act
        final result = await repository.getAllZones();
        final zonInfoList = result.fold((l) => null, (r) => r);
        // assert
        verify(() => mockLocalDataSource.getAllZones()).called(1);
        expect(zonInfoList, tZoneInfoList);
      },
    );

    test(
      "should get all zones from the local data source when there is no internet connection",
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getAllZones())
            .thenAnswer((_) async => tZoneModeList);
        // act
        final result = await repository.getAllZones();
        // assert
        expect(result, isA<Either<Failure, List<ZoneInfo>>>());
      },
    );
  });

  group('addZone', () {
    const tWaypoint =
        WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);
    const tZoneInfo =
        ZoneInfo(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoint]);

    final tZoneModel = ZoneInfoModel.fromEntity(tZoneInfo);

    test('should add zone to the local data source', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.addZone(tZoneModel))
          .thenAnswer((_) async => true);

      final result = await repository.addZone(tZoneInfo, []);

      expect(result, equals(left(NetworkFailure())));
    });

    test(
        'should add zone to the remote data source when there is internet connection',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.addNewZone(tZoneModel, []))
          .thenAnswer((_) async => true);
      // act
      final result = await repository.addZone(tZoneInfo, []);
      // assert
      verify(() => mockRemoteDataSource.addNewZone(tZoneModel, [])).called(1);
      expect(result, equals(right(null)));
    });

    test('should return network failure when there is no internet connection',
        () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.addZone(tZoneInfo, []);
      // assert
      expect(result, equals(left(NetworkFailure())));
    });
  });
}
