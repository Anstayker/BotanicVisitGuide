import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ZoneCreatorLocalDataSource {
  Future<bool> addZone(ZoneModel newZone);
  Future<List<ZoneModel>> getAllZones();
}

// ignore: constant_identifier_names
const CACHE_ZONES_LIST = 'CACHE_ZONES_LIST';

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

    return sharedPreferences.setString(
        CACHE_ZONES_LIST, jsonEncode(zonesInString));
  }

  @override
  Future<List<ZoneModel>> getAllZones() {
    final jsonString = sharedPreferences.getString(CACHE_ZONES_LIST);
    if (jsonString != null) {
      List<ZoneModel> zones = zoneModelFromJson(jsonString);
      return Future.value(zones);
    } else {
      return Future(() => []);
    }
  }
}
