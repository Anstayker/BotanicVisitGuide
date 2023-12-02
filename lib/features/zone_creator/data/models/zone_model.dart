// import 'dart:convert';

import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_model.dart';

import '../../domain/entities/zone_info.dart';

List<ZoneModel> zoneModelFromJson(String str) =>
    List<ZoneModel>.from(json.decode(str).map((x) => ZoneModel.fromJson(x)));

String zoneModelToJson(List<ZoneModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
        zoneId: json["zoneId"],
        name: json["name"],
        waypoints: List<WaypointModel>.from(
            json["waypoints"].map((x) => WaypointModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zoneId": zoneId,
        "name": name,
        "waypoints": List<dynamic>.from(
            waypoints.map((x) => WaypointModel.fromWaypoint(x).toJson())),
      };

  factory ZoneModel.fromEntity(ZoneInfo entity) {
    return ZoneModel(
      zoneId: entity.zoneId,
      name: entity.name,
      waypoints:
          entity.waypoints.map((e) => WaypointModel.fromEntity(e)).toList(),
    );
  }
}
