import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/zone_data_model.dart';

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
    final jsonString = sharedPreferences.getString(cacheZonesData);
    if (jsonString != null) {
      List<ZoneDataModel> zones = zoneDataModelFromJson(jsonString);
      return Future.value(zones);
    } else {
      return Future(() => []);
    }
  }

  @override
  Future<ZoneDataModel> getZoneData(String zoneId) {
    final jsonString = sharedPreferences.getString(cacheZonesData);
    if (jsonString != null) {
      List<ZoneDataModel> zones = zoneDataModelFromJson(jsonString);
      for (var zone in zones) {
        if (zone.zoneId == zoneId) {
          return Future.value(zone);
        }
      }
    }
    throw NotFoundException('Zone not found');
  }
}
