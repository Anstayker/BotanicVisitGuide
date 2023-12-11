import 'package:equatable/equatable.dart';

import 'waypoint_data.dart';

class ZoneData extends Equatable {
  final String zoneId;
  final String zoneName;
  final String zoneDescription;
  final List<WaypointData> waypoints;

  const ZoneData(
      {required this.zoneId,
      required this.zoneName,
      required this.zoneDescription,
      required this.waypoints});

  @override
  List<Object?> get props => [zoneId, zoneName, zoneDescription, waypoints];
}
