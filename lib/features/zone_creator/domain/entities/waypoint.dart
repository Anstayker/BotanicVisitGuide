import 'package:equatable/equatable.dart';

class Waypoint extends Equatable {
  final int waypointId;
  final double lattitude;
  final double longitude;

  const Waypoint(
      {required this.waypointId,
      required this.lattitude,
      required this.longitude});

  @override
  List<Object?> get props => [lattitude, longitude];
}
