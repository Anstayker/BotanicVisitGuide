import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tWaypointModel = WaypointModel(latitud: 1.0, longitud: 1.0);

  test(
    "should be a subclass of Waypoint entity",
    () async {
      // assert
      expect(tWaypointModel, isA<Waypoint>());
    },
  );
}
