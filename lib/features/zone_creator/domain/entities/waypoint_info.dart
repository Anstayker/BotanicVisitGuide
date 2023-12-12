import 'package:equatable/equatable.dart';

class WaypointInfo extends Equatable {
  final String waypointId;
  final double latitude;
  final double longitude;

  const WaypointInfo(
      {required this.waypointId,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [waypointId, latitude, longitude];
}
