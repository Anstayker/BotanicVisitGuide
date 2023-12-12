import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../models/zone_model.dart';

abstract class ZoneCreatorLocalDataSource {
  Future<bool> addZone(ZoneModel newZone);
  Future<List<ZoneModel>> getAllZones();
}

class ZoneCreatorLocalDataSourceImpl implements ZoneCreatorLocalDataSource {
  final SharedPreferences sharedPreferences;

  ZoneCreatorLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> addZone(ZoneModel newZone) async {
    List<String> zonesInJson = [];
    final currentZones = await getAllZones();
    currentZones.add(newZone);
    for (var zone in currentZones) {
      zonesInJson.add(jsonEncode(zone.toJson()));
    }
    String zonesInString = '[${zonesInJson.join(',')}]';
    return sharedPreferences.setString(cacheZonesList, zonesInString);
  }

  @override
  Future<List<ZoneModel>> getAllZones() {
    final jsonString = sharedPreferences.getString(cacheZonesList);
    if (jsonString != null) {
      List<ZoneModel> zones = zoneModelFromJson(jsonString);
      return Future.value(zones);
    } else {
      return Future(() => []);
    }
  }
}
