import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_creator_model.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tZoneCreatorModel = ZoneCreatorModel(zoneId: 1, zoneName: 'Zone 1');

  test(
    "Should be a subclass of ZoneCreator entity",
    () async {
      // assert
      expect(tZoneCreatorModel, isA<ZoneCreator>());
    },
  );
}
