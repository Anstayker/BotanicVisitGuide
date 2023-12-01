import '../../domain/entities/zone_info.dart';
import 'dart:convert';

class ZoneModel extends ZoneInfo {
  const ZoneModel({required zoneId, required name, required waypoints})
      : super(zoneId: zoneId, name: name, waypoints: waypoints);

  Map<String, dynamic> toMap() {
    return {
      'zoneId': zoneId,
      'name': name,
      'waypoints': waypoints,
    };
  }

  static ZoneInfo fromMap(Map<String, dynamic> map) {
    return ZoneInfo(
      zoneId: map['zoneId'],
      name: map['name'],
      waypoints: map['waypoints'],
    );
  }

  String toJson() => json.encode(toMap());

  static ZoneInfo fromJson(String source) => fromMap(json.decode(source));
}
