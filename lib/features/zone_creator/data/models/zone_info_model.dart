// import 'dart:convert';

import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';

import '../../domain/entities/zone_info.dart';

List<ZoneInfoModel> zoneModelFromJson(String str) => List<ZoneInfoModel>.from(
    json.decode(str).map((x) => ZoneInfoModel.fromJson(x)));

String zoneModelToJson(List<ZoneInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneInfoModel extends ZoneInfo {
  const ZoneInfoModel({required zoneId, required name, required waypoints})
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

  factory ZoneInfoModel.fromJson(Map<String, dynamic> json) => ZoneInfoModel(
        zoneId: json["zoneId"],
        name: json["name"],
        waypoints: List<WaypointInfoModel>.from(
            json["waypoints"].map((x) => WaypointInfoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zoneId": zoneId,
        "name": name,
        "waypoints": List<dynamic>.from(
            waypoints.map((x) => WaypointInfoModel.fromWaypoint(x).toJson())),
      };

  factory ZoneInfoModel.fromEntity(ZoneInfo entity) {
    return ZoneInfoModel(
      zoneId: entity.zoneId,
      name: entity.name,
      waypoints:
          entity.waypoints.map((e) => WaypointInfoModel.fromEntity(e)).toList(),
    );
  }
}
