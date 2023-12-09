import 'dart:convert';

import '../../domain/entities/waypoint_data.dart';

import 'waypoint_data_model.dart';

List<ZoneDataModel> zoneDataModelFromJson(String str) =>
    List<ZoneDataModel>.from(
        json.decode(str).map((x) => ZoneDataModel.fromJson(x)));

String zoneDataModelToJson(List<ZoneDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneDataModel {
  String zoneId;
  String name;
  String? description;
  List<WaypointData> waypoints;

  ZoneDataModel({
    required this.zoneId,
    required this.name,
    this.description,
    required this.waypoints,
  });

  factory ZoneDataModel.fromJson(Map<String, dynamic> json) => ZoneDataModel(
        zoneId: json["zoneId"],
        name: json["name"],
        description: json["description"],
        waypoints: List<WaypointData>.from(
            json["waypoints"].map((x) => WaypointDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zoneId": zoneId,
        "name": name,
        "description": description,
        "waypoints": List<dynamic>.from(waypoints
            .map((x) => WaypointDataModel.fromWaypointData(x).toJson())),
      };
}
