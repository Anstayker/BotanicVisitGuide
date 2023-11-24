import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_creator.dart';

class ZoneCreatorModel extends ZoneCreator {
  const ZoneCreatorModel({
    required int zoneId,
    required String zoneName,
  }) : super(
          zoneId: zoneId,
          zoneName: zoneName,
        );
}
