import '../../domain/entities/waypoint_info.dart';

class WaypointInfoModel extends WaypointInfo {
  const WaypointInfoModel(
      {required waypointId, required latitude, required longitude})
      : super(waypointId: waypointId, latitude: latitude, longitude: longitude);

  factory WaypointInfoModel.fromJson(Map<String, dynamic> json) {
    return WaypointInfoModel(
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

  Map<String, dynamic> toMap() {
    return {
      'waypointId': waypointId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static WaypointInfoModel fromMap(Map<String, dynamic> map) {
    return WaypointInfoModel(
      waypointId: map['waypointId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  static WaypointInfoModel fromWaypoint(WaypointInfo waypoint) {
    return WaypointInfoModel(
      waypointId: waypoint.waypointId,
      latitude: waypoint.latitude,
      longitude: waypoint.longitude,
    );
  }

  factory WaypointInfoModel.fromEntity(WaypointInfo entity) {
    return WaypointInfoModel(
      waypointId: entity.waypointId,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
