import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/datasources/zone_finder_local_datasource.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/models/waypoint_data_model.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ZoneFinderLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        ZoneFinderLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getAllZones', () {
    const tZoneListString =
        '[{"zoneId":"1","name":"name","waypoints":[{"waypointId":"1","latitude":1.0,"longitude":1.0}]}]';
    const WaypointDataModel tWaypointDataModel =
        WaypointDataModel(waypointId: '1', latitude: 1.0, longitude: 1.0);
    const ZoneDataModel tZoneDataModel = ZoneDataModel(
        zoneId: '1', zoneName: 'name', waypoints: [tWaypointDataModel]);
    final List<ZoneDataModel> tZoneList = [tZoneDataModel];

    test('should return ZoneDataList when there is one in the cache', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(tZoneListString);
      // act
      final result = await localDataSource.getAllZones();
      // assert
      verify(() => mockSharedPreferences.getString('CACHE_ZONES_DATA'));
      for (var i = 0; i < result.length; i++) {
        expect(result[i].zoneId, equals(tZoneList[i].zoneId));
        expect(result[i].zoneName, equals(tZoneList[i].zoneName));
        expect(result[i].zoneDescription, equals(tZoneList[i].zoneDescription));
        expect(result[i].waypoints, equals(tZoneList[i].waypoints));
      }
    });

    test('should return empty list when there is no cache', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final result = await localDataSource.getAllZones();
      // assert
      verify(() => mockSharedPreferences.getString('CACHE_ZONES_DATA'));
      expect(result, equals([]));
    });
  });

  group('getZoneData', () {
    const tZoneId = '123';
    const tWaypoint =
        WaypointDataModel(waypointId: '1', latitude: 1.0, longitude: 1.0);
    const tZoneDataModel = ZoneDataModel(
        zoneId: tZoneId, zoneName: 'ZoneName', waypoints: [tWaypoint]);
    String zoneDataModelEncoded = jsonEncode(tZoneDataModel.toJson());
    final jsonString = '[$zoneDataModelEncoded]';

    test('should return ZoneDataModel when zoneId exists', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(jsonString);
      // act
      final result = await localDataSource.getZoneData(tZoneId);
      // assert
      expect(result.zoneId, equals(tZoneDataModel.zoneId));
      expect(result.zoneName, equals(tZoneDataModel.zoneName));
      expect(result.zoneDescription, equals(tZoneDataModel.zoneDescription));
      expect(result.waypoints, equals(tZoneDataModel.waypoints));
    });

    test('should throw NotFoundException when zoneId does not exist', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(jsonString);
      // act
      final call = localDataSource.getZoneData;
      // assert
      expect(
          () => call('invalid_id'), throwsA(isInstanceOf<NotFoundException>()));
    });
  });
}
