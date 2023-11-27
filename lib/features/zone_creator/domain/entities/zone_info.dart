import 'package:equatable/equatable.dart';

import 'waypoint.dart';

class ZoneInfo extends Equatable {
  final int id;
  final String name;
  final List<Waypoint> waypoints;

  const ZoneInfo(
      {required this.id, required this.name, required this.waypoints});

  @override
  List<Object?> get props => [name, waypoints];
}
