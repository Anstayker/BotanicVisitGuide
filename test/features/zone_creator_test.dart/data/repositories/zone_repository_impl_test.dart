import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/datasources/local/zone_creator_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/repositories/zone_repository_impl.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLocalDataSource extends Mock implements ZoneCreatorLocalDataSource {}

void main() {
  late ZoneRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = ZoneRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('getAllZones', () {
    const tWaypoint = WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);
    final tZoneModeList = [
      const ZoneModel(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoint])
    ];
    final tZoneInfoList = tZoneModeList
        .map((e) =>
            ZoneInfo(zoneId: e.zoneId, name: e.name, waypoints: e.waypoints))
        .toList();

    test(
      "should get all zones from the local data source",
      () async {
        // arrange
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
      "should return a list of ZoneInfo when getAllZones is successful",
      () async {
        // arrange
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
    const tWaypoint = WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);
    const tZoneInfo =
        ZoneInfo(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoint]);

    final tZoneModel = ZoneModel.fromEntity(tZoneInfo);

    test('should add zone to the local data source', () async {
      when(() => mockLocalDataSource.addZone(tZoneModel))
          .thenAnswer((_) async => true);

      final result = await repository.addZone(tZoneInfo);

      verify(() => mockLocalDataSource.addZone(tZoneModel)).called(1);
      expect(result, equals(right(null)));
    });
  });
}
