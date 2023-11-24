import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_creator_model.dart';

abstract class ZoneCreatorRemoteDataSource {
  Future<ZoneCreatorModel> getZoneInformation(int zoneId);
}
