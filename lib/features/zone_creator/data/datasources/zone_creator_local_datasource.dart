import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_creator_model.dart';

abstract class ZoneCreatorLocalDataSource {
  /// Gets the cached [ZoneCreatorModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<ZoneCreatorModel> getLastZoneCreator();

  Future<void> cacheZoneCreator(ZoneCreatorModel zoneCreatorToCache);
}
