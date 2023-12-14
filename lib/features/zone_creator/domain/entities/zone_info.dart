import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'waypoint_info.dart';

class ZoneInfo extends Equatable {
  final String zoneId;
  final String name;
  final List<WaypointInfo> waypoints;
  final String? description;
  final ValueNotifier<List<String>?>? images;
  final String? audio;

  const ZoneInfo({
    required this.zoneId,
    required this.name,
    required this.waypoints,
    this.description,
    this.images,
    this.audio,
  });

  @override
  List<Object?> get props =>
      [zoneId, name, waypoints, description, images?.value, audio];
}
