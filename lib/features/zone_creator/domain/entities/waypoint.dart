import 'package:equatable/equatable.dart';

class Waypoint extends Equatable {
  final double latitud;
  final double longitud;

  const Waypoint({required this.latitud, required this.longitud});

  @override
  List<Object?> get props => [latitud, longitud];
}
