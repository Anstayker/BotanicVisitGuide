import '../../domain/entities/waypoint_info.dart';

class WaypointModel extends WaypointInfo {
  const WaypointModel(
      {required waypointId, required latitude, required longitude})
      : super(waypointId: waypointId, latitude: latitude, longitude: longitude);

  factory WaypointModel.fromJson(Map<String, dynamic> json) {
    return WaypointModel(
      waypointId: json['waypointId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waypointId': waypointId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static WaypointModel fromWaypoint(WaypointInfo waypoint) {
    return WaypointModel(
      waypointId: waypoint.waypointId,
      latitude: waypoint.latitude,
      longitude: waypoint.longitude,
    );
  }

  factory WaypointModel.fromEntity(WaypointInfo entity) {
    return WaypointModel(
      waypointId: entity.waypointId,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
