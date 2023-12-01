import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWaypointModel =
      WaypointModel(waypointId: 1, lattitude: 1.0, longitude: 1.0);
  const tZoneModel =
      ZoneModel(zoneId: 1, name: 'name', waypoints: [tWaypointModel]);
  const tZoneInfo =
      ZoneInfo(zoneId: 1, name: 'name', waypoints: [tWaypointModel]);
  final tMap = {
    'zoneId': 1,
    'name': 'name',
    'waypoints': [tWaypointModel],
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
      final result = ZoneModel.fromMap(tMap);
      expect(result, tZoneInfo);
    },
  );

  group('from Json', () {
    final jsonWithOneElement = fixture('zone_creator_cached.json');
    final expectedMap = ZoneModel(zoneId: 1, name: 'Zone Name', waypoints: []);

    test(
      "should be able to convert a Json to a valid Map",
      () async {
        // act
        final result = ZoneModel.fromJson(jsonWithOneElement);
        // assert
        expect(result, expectedMap);
      },
    );
  });
}
