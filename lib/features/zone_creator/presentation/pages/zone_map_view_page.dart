import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/entities/waypoint_data.dart';
import 'package:botanic_visit_guide/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/services/geolocator_wrapper.dart';

class MapView extends StatelessWidget {
  final List<WaypointInfo> waypointsData;

  const MapView({super.key, required this.waypointsData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: sl<GeolocatorWrapper>().getCurrentPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera la posición
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
          } else {
            final List<LatLng> waypoints = waypointsData.map((waypoint) {
              return LatLng(waypoint.latitude, waypoint.longitude);
            }).toList();
            final LatLng currentPosition =
                LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
            var markers = waypoints.map((waypoint) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: waypoint,
                builder: (ctx) => const FlutterLogo(),
              );
            }).toList()
              ..add(
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: currentPosition,
                  builder: (ctx) =>
                      const Icon(Icons.location_on, color: Colors.red),
                ),
              );

            return FlutterMap(
              options: MapOptions(
                center: currentPosition,
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            );
          }
        });
  }
}
