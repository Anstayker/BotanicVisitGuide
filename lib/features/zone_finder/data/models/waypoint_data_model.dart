import '../../domain/entities/waypoint_data.dart';

class WaypointDataModel extends WaypointData {
  const WaypointDataModel({
    required waypointId,
    required latitude,
    required longitude,
  }) : super(waypointId: waypointId, latitude: latitude, longitude: longitude);

  factory WaypointDataModel.fromJson(Map<String, dynamic> json) =>
      WaypointDataModel(
        waypointId: json["waypointId"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "waypointId": waypointId,
        "latitude": latitude,
        "longitude": longitude,
      };

  static WaypointDataModel fromWaypointData(WaypointData waypoint) {
    return WaypointDataModel(
      waypointId: waypoint.waypointId,
      latitude: waypoint.latitude,
      longitude: waypoint.longitude,
    );
  }
}
