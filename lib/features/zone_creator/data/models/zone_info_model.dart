// import 'dart:convert';

import 'dart:convert';

import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';

import '../../domain/entities/zone_info.dart';

List<ZoneInfoModel> zoneModelFromJson(String str) => List<ZoneInfoModel>.from(
    json.decode(str).map((x) => ZoneInfoModel.fromJson(x)));

String zoneModelToJson(List<ZoneInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneInfoModel extends ZoneInfo {
  const ZoneInfoModel({
    required String zoneId,
    required String name,
    required List<WaypointInfoModel> waypoints,
    String? description,
    List<String>? images,
    String? audio,
  }) : super(
          zoneId: zoneId,
          name: name,
          waypoints: waypoints,
          description: description,
          images: images,
          audio: audio,
        );

  Map<String, dynamic> toMap() {
    return {
      'zoneId': zoneId,
      'name': name,
      'waypoints': waypoints
          .map((waypoint) => (waypoint as WaypointInfoModel).toMap())
          .toList(),
      'description': description,
      'images': images,
      'audio': audio,
    };
  }

  static ZoneInfoModel fromMap(Map<String, dynamic> map) {
    return ZoneInfoModel(
      zoneId: map['zoneId'],
      name: map['name'],
      waypoints: List<WaypointInfoModel>.from(
          map['waypoints'].map((x) => WaypointInfoModel.fromMap(x))),
      description: map['description'],
      images: List<String>.from(map['images'] ?? []),
      audio: map['audio'],
    );
  }

  factory ZoneInfoModel.fromJson(Map<String, dynamic> json) {
    return ZoneInfoModel(
      zoneId: json["zoneId"],
      name: json["name"],
      waypoints: List<WaypointInfoModel>.from(
          json["waypoints"].map((x) => WaypointInfoModel.fromJson(x))),
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      audio: json['audio'],
    );
  }

  Map<String, dynamic> toJson() => {
        "zoneId": zoneId,
        "name": name,
        "waypoints": List<dynamic>.from(
            waypoints.map((x) => WaypointInfoModel.fromWaypoint(x).toJson())),
        "description": description,
        "images": images,
        "audio": audio,
      };

  factory ZoneInfoModel.fromEntity(ZoneInfo entity) {
    return ZoneInfoModel(
      zoneId: entity.zoneId,
      name: entity.name,
      waypoints:
          entity.waypoints.map((e) => WaypointInfoModel.fromEntity(e)).toList(),
      description: entity.description,
      images: entity.images,
      audio: entity.audio,
    );
  }
}
