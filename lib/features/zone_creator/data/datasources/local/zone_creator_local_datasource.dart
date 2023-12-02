import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ZoneCreatorLocalDataSource {
  Future<void> addZone();
  Future<List<ZoneModel>> getAllZones();
}

const CACHE_ZONES_LIST = 'CACHE_ZONES_LIST';

class ZoneCreatorLocalDataSourceImpl implements ZoneCreatorLocalDataSource {
  final SharedPreferences sharedPreferences;

  ZoneCreatorLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addZone() {
    // TODO: implement addZone
    throw UnimplementedError();
  }

  @override
  Future<List<ZoneModel>> getAllZones() {
    final jsonString = sharedPreferences.getString(CACHE_ZONES_LIST);
    if (jsonString != null) {
      List<ZoneModel> zones = zoneModelFromJson(jsonString);
      return Future.value(zones);
    } else {
      throw Exception();
    }
  }
}
