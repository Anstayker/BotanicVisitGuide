import 'package:equatable/equatable.dart';

class Waypoint extends Equatable {
  final int waypointId;
  final double latitude;
  final double longitude;

  const Waypoint(
      {required this.waypointId,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
