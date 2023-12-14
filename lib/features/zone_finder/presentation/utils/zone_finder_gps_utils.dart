import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/features/zone_finder/data/models/zone_data_model.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/gps_service.dart';
import '../../../../injection_container.dart';
import '../../data/datasources/zone_finder_local_datasource.dart';
import '../../domain/entities/zone_data.dart';

class ZoneFinderGPSUtils {
  Future<List<ZoneData>> getActiveZones(List<ZoneData> zonesDataList) async {
    final List<ZoneData> result = [];

    if (zonesDataList.isNotEmpty) {
      print('No esta vacio');
      var gpsCurrentPosition = await sl<GpsService>().currentPosition;
      gpsCurrentPosition.fold((l) => Exception(PermissionException), (r) {
        final currentPosition = r;
        for (var zoneData in zonesDataList) {
          print('Estoy iterando');
          final waypointList = zoneData.waypoints;
          print(currentPosition);
          if (_isPointInPolygon(waypointList, currentPosition)) {
            print('Funciona!');
            result.add(zoneData);
          }
        }
        return result;
      });
    }

    return result;
  }

  Future<List<ZoneData>> getFoundZones(List<ZoneData> zonesDataList) async {
    final List<ZoneData> result = [];
    final cacheZonesDataJson =
        sl<SharedPreferences>().getString(cacheZonesData);
    if (cacheZonesDataJson != null) {
      var gpsCurrenPosition = await sl<GpsService>().currentPosition;
      gpsCurrenPosition.fold((l) => Exception(PermissionException), (r) {
        final currentPosition = r;
        final cachedZonesDataList = zoneDataModelFromJson(cacheZonesData);

        for (var zoneData in cachedZonesDataList) {
          if (zonesDataList.contains(zoneData)) {
            final waypointList = zoneData.waypoints;
            if (_isPointInPolygon(waypointList, currentPosition)) {
              result.add(zoneData);
            }
          }
        }
      });
    }
    return result;
  }

  bool _isPointInPolygon(List<WaypointData> polygon, Position point) {
    print('Comprobanding');
    bool isInside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      if ((polygon[i].longitude > point.longitude) !=
              (polygon[j].longitude > point.longitude) &&
          (point.latitude <
              (polygon[j].latitude - polygon[i].latitude) *
                      (point.longitude - polygon[i].longitude) /
                      (polygon[j].longitude - polygon[i].longitude) +
                  polygon[i].latitude)) {
        isInside = !isInside;
      }
    }
    return isInside;
  }
}
