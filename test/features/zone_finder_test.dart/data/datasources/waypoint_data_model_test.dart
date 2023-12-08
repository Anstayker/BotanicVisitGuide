import 'package:botanic_visit_guide/features/zone_finder/data/models/waypoint_data_model.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tWaypointDataModel = WaypointDataModel(
    waypointId: '1',
    latitude: 1.0,
    longitude: 1.0,
  );

  final tJsonMap = {
    "waypointId": '1',
    "latitude": 1.0,
    "longitude": 1.0,
  };

  test('should be a subclass of WaypointData entity', () async {
    // assert
    expect(tWaypointDataModel, isA<WaypointData>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // act
      final result = WaypointDataModel.fromJson(tJsonMap);
      // assert
      expect(result, tWaypointDataModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tWaypointDataModel.toJson();
      // assert
      expect(result, tJsonMap);
    });
  });
}
