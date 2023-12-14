import 'package:botanic_visit_guide/core/constants/constants.dart';
import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/usecases/add_zone.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/usecases/get_all_zones.dart';
import 'package:botanic_visit_guide/features/zone_creator/presentation/bloc/bloc.dart';

class MockGetAllZones extends Mock implements GetAllZones {}

class MockAddZone extends Mock implements AddZone {}

void main() {
  late ZoneCreatorBloc bloc;
  late MockGetAllZones mockGetAllZones;
  late MockAddZone mockAddZone;

  setUp(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(const Params(
        zone: ZoneInfo(zoneId: '1', name: 'Zone', waypoints: [
          WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0)
        ]),
        images: []));
    mockGetAllZones = MockGetAllZones();
    mockAddZone = MockAddZone();
    bloc = ZoneCreatorBloc(
      addZone: mockAddZone,
      getAllZones: mockGetAllZones,
    );
  });

  test(
    "initialState should be ZoneCreatorInitial",
    () async {
      // assert
      expect(bloc.state, equals(ZoneCreatorInitial()));
    },
  );

  group('GetAllZones', () {
    const tWaypoints =
        WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);

    const tZones = [
      ZoneInfo(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoints]),
      ZoneInfo(zoneId: '2', name: 'Zone 2', waypoints: [tWaypoints]),
    ];

    test(
      "should get data form the get all zones use case",
      () async {
        // arrange
        when(() => mockGetAllZones(any()))
            .thenAnswer((_) async => const Right(tZones));
        // act
        bloc.add(GetAllZonesEvent());
        await untilCalled(() => mockGetAllZones(any()));
        // assert
        verify(() => mockGetAllZones(NoParams()));
      },
    );

    test(
      "should emit [ZoneLoading, ZoneLoadSuccess] when data is gotten succesfully",
      () async {
        // arrange
        when(() => mockGetAllZones(any()))
            .thenAnswer((_) async => const Right(tZones));
        // assert later
        final expected = [
          ZoneLoading(),
          const ZoneLoadSuccess(zones: tZones),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetAllZonesEvent());
      },
    );

    test(
      "should emit [ZoneLoading, ZoneLoadFailure] when getting data fails",
      () async {
        // arrange
        when(() => mockGetAllZones(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          ZoneLoading(),
          const ZoneLoadFailure(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetAllZonesEvent());
      },
    );
  });

  group('AddZone', () {
    const tWaypoints =
        WaypointInfo(waypointId: '1', latitude: 1.0, longitude: 1.0);
    const tZone =
        ZoneInfo(zoneId: '1', name: 'Zone 1', waypoints: [tWaypoints]);
    test(
      "should add a new Zone in the add new zone use case",
      () async {
        // arrange
        when(() => mockAddZone(any()))
            .thenAnswer((_) async => const Right(null));
        // act
        bloc.add(const AddZoneEvent(zone: tZone, images: []));
        await untilCalled(() => mockAddZone(any()));
        // assert
        verify(() => mockAddZone(const Params(zone: tZone, images: [])));
      },
    );
  });
}
