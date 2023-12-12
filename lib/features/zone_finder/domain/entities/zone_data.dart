import 'package:equatable/equatable.dart';

import 'waypoint_data.dart';

class ZoneData extends Equatable {
  final String zoneId;
  final String zoneName;
  final List<WaypointData> waypoints;
  final String? zoneDescription;
  final List<String>? images;
  final String? audio;

  const ZoneData(
      {required this.zoneId,
      required this.zoneName,
      required this.waypoints,
      this.zoneDescription,
      this.images,
      this.audio
      });

  @override
  List<Object?> get props => [zoneId, zoneName, zoneDescription, waypoints, images, audio];
}
