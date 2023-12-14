import 'package:botanic_visit_guide/features/zone_finder/data/models/waypoint_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';

void main() {
  group('ZoneDataModel', () {
    test('should correctly serialize to JSON', () {
      // arrange
      const model = ZoneDataModel(
        zoneId: "1",
        zoneName: 'Test Zone',
        description: 'This is a test zone',
        waypoints: [
          WaypointDataModel(waypointId: '1', latitude: 1.0, longitude: 1.0)
        ],
      );

      // act
      final json = model.toJson();

      // assert
      expect(json, isNotNull);
      expect(json['zoneId'], "1");
      expect(json['name'], 'Test Zone');
      expect(json['description'], 'This is a test zone');
    });

    test('should correctly deserialize from JSON', () {
      // arrange
      final json = {
        'zoneId': "1",
        'name': 'Test Zone',
        'description': 'This is a test zone',
        'waypoints': [
          {'waypointId': '1', 'latitude': 1.0, 'longitude': 1.0}
        ],
      };

      // act
      final fromJsonModel = ZoneDataModel.fromJson(json);

      // assert
      expect(fromJsonModel, isNotNull);
      expect(fromJsonModel.zoneId, "1");
      expect(fromJsonModel.zoneName, 'Test Zone');
      expect(fromJsonModel.zoneDescription, 'This is a test zone');
    });
  });
}
