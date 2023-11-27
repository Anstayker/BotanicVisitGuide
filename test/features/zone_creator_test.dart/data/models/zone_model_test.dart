import 'dart:math';

import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tZoneModel = ZoneModel(id: 1, name: 'name', waypoints: const []);
  final tMap = {
    'id': 1,
    'name': 'name',
    'waypoints': const [],
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
      expect(result, tZoneModel);
    },
  );
}
