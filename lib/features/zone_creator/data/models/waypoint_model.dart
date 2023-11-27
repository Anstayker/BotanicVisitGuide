import '../../domain/entities/waypoint.dart';

class WaypointModel extends Waypoint {
  const WaypointModel({required latitud, required longitud})
      : super(latitud: latitud, longitud: longitud);
}
