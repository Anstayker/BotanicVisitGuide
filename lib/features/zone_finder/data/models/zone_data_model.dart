import 'dart:convert';

import '../../domain/entities/zone_data.dart';

import 'waypoint_data_model.dart';

List<ZoneDataModel> zoneDataModelFromJson(String str) =>
    List<ZoneDataModel>.from(
        json.decode(str).map((x) => ZoneDataModel.fromJson(x)));

String zoneDataModelToJson(List<ZoneDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneDataModel extends ZoneData {
  const ZoneDataModel({
    required String zoneId,
    required String zoneName,
    required List<WaypointDataModel> waypoints,
    String? description,
    List<String>? images,
    String? audio,
  }) : super(
            zoneId: zoneId,
            zoneName: zoneName,
            waypoints: waypoints,
            zoneDescription: description,
            images: images,
            audio: audio);

  factory ZoneDataModel.fromJson(Map<String, dynamic> json) => ZoneDataModel(
        zoneId: json["zoneId"],
        zoneName: json["name"],
        description: json["description"],
        waypoints: List<WaypointDataModel>.from(
            json["waypoints"].map((x) => WaypointDataModel.fromJson(x))),
        images:
            json["images"] != null ? List<String>.from(json["images"]) : null,
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "zoneId": zoneId,
        "name": zoneName,
        "description": zoneDescription,
        "waypoints": List<dynamic>.from(waypoints
            .map((x) => WaypointDataModel.fromWaypointData(x).toJson())),
        "images": images != null ? List<dynamic>.from(images!) : null,
        "audio": audio,
      };

  // ZoneData toZoneData() {
  //   return ZoneData(
  //     zoneId: zoneId,
  //     zoneName: name,
  //     zoneDescription: description ?? '',
  //     waypoints: waypoints
  //         .map((waypointModel) => waypointModel.toWaypointData())
  //         .toList(),
  //   );
  // }
}
