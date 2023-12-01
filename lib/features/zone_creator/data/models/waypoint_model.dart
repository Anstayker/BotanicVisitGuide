import '../../domain/entities/waypoint.dart';

class WaypointModel extends Waypoint {
  const WaypointModel(
      {required waypointId, required lattitude, required longitude})
      : super(
            waypointId: waypointId, lattitude: lattitude, longitude: longitude);

  factory WaypointModel.fromJson(Map<String, dynamic> json) {
    return WaypointModel(
      waypointId: json['waypointId'],
      lattitude: json['lattitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waypointId': waypointId,
      'lattitude': lattitude,
      'longitude': longitude,
    };
  }
}
