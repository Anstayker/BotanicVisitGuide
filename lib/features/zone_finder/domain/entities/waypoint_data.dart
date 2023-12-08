import 'package:equatable/equatable.dart';

class WaypointData extends Equatable {
  final int waypointId;
  final double latitude;
  final double longitude;

  const WaypointData(
      {required this.waypointId,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [waypointId, latitude, longitude];
}
