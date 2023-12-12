import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWaypointModel =
      WaypointInfoModel(waypointId: '1', latitude: 1.0, longitude: 1.0);

  test(
    "should be a subclass of Waypoint entity",
    () async {
      // assert
      expect(tWaypointModel, isA<WaypointInfo>());
    },
  );

  test(
    "should return a valid model from Json",
    () async {
      // act
      final waypointJson = json.decode(fixture('waypoint_example.json'));
      final result = WaypointInfoModel.fromJson(waypointJson);
      // assert
      expect(result.waypointId, tWaypointModel.waypointId);
      expect(result.latitude, tWaypointModel.latitude);
      expect(result.longitude, tWaypointModel.longitude);
    },
  );

  test(
    "should return a valid Json from model",
    () async {
      // arrange
      final matcher = json.decode(fixture('waypoint_example.json'));
      // act
      final result = tWaypointModel.toJson();
      // assert
      expect(result, matcher);
    },
  );
}
