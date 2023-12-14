import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_info_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWaypointModel =
      WaypointInfoModel(waypointId: '1', latitude: 1.0, longitude: 1.0);
  const tZoneModel = ZoneInfoModel(
      zoneId: '1', name: 'name', waypoints: [tWaypointModel], images: []);
  // final tZoneInfo = ZoneInfo(
  //     zoneId: '1',
  //     name: 'name',
  //     waypoints: const [tWaypointModel],
  //     images: ValueNotifier<List<String>?>(null));
  final tMap = {
    'zoneId': '1',
    'name': 'name',
    'waypoints': [
      {'waypointId': '1', 'latitude': 1.0, 'longitude': 1.0}
    ],
    'description': null,
    'images': [],
    'audio': null
  };

  test(
    "should be a subclass of Zone entity",
    () async {
      // assert
      expect(tZoneModel, isA<ZoneInfo>());
    },
  );

  test(
    "should be able to convert a ZoneModel to a Map",
    () async {
      final result = tZoneModel.toMap();
      expect(result, tMap);
    },
  );

  test(
    "should be able to convert a Map to a ZoneModel",
    () async {
      final result = ZoneInfoModel.fromMap(tMap);
      expect(result, tZoneModel);
    },
  );

  test(
    "should return a valid model from Json",
    () async {
      // act
      final zoneJson = json.decode(fixture('zone_example.json'));
      final result = ZoneInfoModel.fromJson(zoneJson[0]);
      // assert
      expect(result.zoneId, tZoneModel.zoneId);
      expect(result.name, tZoneModel.name);
      expect(result.waypoints, tZoneModel.waypoints);
    },
  );

  test(
    "should return a valid model to Json",
    () async {
      // act
      final result = [tZoneModel.toJson()];
      // assert
      expect(result, json.decode(fixture('zone_example.json')));
    },
  );

  test(
    "should be able to convert from JSON to ZoneModel",
    () async {
      // act
      final tZoneModelJson =
          jsonEncode(jsonDecode(fixture('zone_example.json')));
      final result = zoneModelFromJson(tZoneModelJson);
      // assert
      expect(result, [tZoneModel]);
    },
  );

  test(
    "should be abe to convert from ZoneModel to JSON",
    () async {
      // act
      final result = zoneModelToJson([tZoneModel]);
      final matcher = jsonEncode(jsonDecode(fixture('zone_example.json')));
      // assert
      expect(result, matcher);
    },
  );
}
