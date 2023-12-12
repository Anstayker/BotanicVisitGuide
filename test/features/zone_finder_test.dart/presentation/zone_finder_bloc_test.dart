import 'package:botanic_visit_guide/core/constants/constants.dart';
import 'package:botanic_visit_guide/core/errors/failures.dart';
import 'package:botanic_visit_guide/core/usecases/usecase.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/zone_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_all_zones_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/presentation/bloc/zone_finder_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetAllZonesData extends Mock implements GetAllZonesData {}

class MockGetZoneData extends Mock implements GetZoneDataEvent {}

void main() {
  late GetAllZonesData getAllZonesData;
  late GetZoneDataEvent getZoneData;
  late ZoneFinderBloc bloc;

  setUp(() {
    registerFallbackValue(NoParams());
    getAllZonesData = MockGetAllZonesData();
    getZoneData = MockGetZoneData();
    bloc = ZoneFinderBloc(
      getAllZonesData: getAllZonesData,
      getZoneData: getZoneData,
    );
  });

  test(
    "initialState should be ZoneFinderInitial",
    () async {
      // assert
      expect(bloc.state, equals(ZoneFinderInitial()));
    },
  );

  group('GetAllZones', () {
    const tWaypoints =
        WaypointData(waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
    const tZones = [
      ZoneData(
          zoneId: 'zoneId1',
          zoneName: 'zoneName1',
          zoneDescription: 'zoneDescription',
          waypoints: [tWaypoints]),
      ZoneData(
          zoneId: 'zoneId2',
          zoneName: 'zoneName2',
          zoneDescription: 'zoneDescription',
          waypoints: [tWaypoints]),
    ];
    test(
      "should get data form the get all zones data use case",
      () async {
        // arrange
        when(() => getAllZonesData(any()))
            .thenAnswer((_) async => const Right(tZones));
        // act
        bloc.add(GetAllZonesEvent());
        await untilCalled(() => getAllZonesData(any()));
        // assert
        verify(() => getAllZonesData(NoParams()));
      },
    );

    test(
      "should emit [ZonesLoading, ZonesLoadSuccess] when data is gotten succesfully",
      () async {
        // arrange
        when(() => getAllZonesData(any()))
            .thenAnswer((_) async => const Right(tZones));
        // assert later
        final expected = [
          ZonesLoading(),
          const ZonesLoadSuccess(zones: tZones),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetAllZonesEvent());
      },
    );

    test(
      "should emit [ZonesLoading, ZonesLoadFailure] when getting data fails",
      () async {
        // arrange
        when(() => getAllZonesData(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          ZonesLoading(),
          const ZonesLoadFailure(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetAllZonesEvent());
      },
    );
  });
}
