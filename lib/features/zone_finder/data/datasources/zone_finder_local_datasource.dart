import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ZoneFinderLocalDataSource {
  Future<List<ZoneDataModel>> getAllZones();
  Future<ZoneDataModel> getZoneData(String zoneId);
}

const cacheZonesData = 'CACHE_ZONES_DATA';

class ZoneFinderLocalDataSourceImpl implements ZoneFinderLocalDataSource {
  final SharedPreferences sharedPreferences;

  ZoneFinderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ZoneDataModel>> getAllZones() {
    // TODO: implement getAllZones
    throw UnimplementedError();
  }

  @override
  Future<ZoneDataModel> getZoneData(String zoneId) {
    // TODO: implement getZoneData
    throw UnimplementedError();
  }
}
