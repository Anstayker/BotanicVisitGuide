import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWaypointModel =
      WaypointModel(waypointId: 1, lattitude: 1.0, longitude: 1.0);

  test(
    "should be a subclass of Waypoint entity",
    () async {
      // assert
      expect(tWaypointModel, isA<Waypoint>());
    },
  );

  test(
    "should return a valid model from Json",
    () async {
      // act
      final waypointJson = json.decode(fixture('waypoint_example.json'));
      final result = WaypointModel.fromJson(waypointJson);
      // assert
      expect(result.waypointId, tWaypointModel.waypointId);
      expect(result.lattitude, tWaypointModel.lattitude);
      expect(result.longitude, tWaypointModel.longitude);
    },
  );
}
