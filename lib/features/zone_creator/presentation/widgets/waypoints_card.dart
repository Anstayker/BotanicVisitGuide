import 'package:flutter/material.dart';

import '../../domain/entities/waypoint_info.dart';

class WaypointsCard extends StatelessWidget {
  const WaypointsCard({
    super.key,
    required List<WaypointInfo> waypointsList,
    required this.index,
  }) : _waypointsList = waypointsList;

  final List<WaypointInfo> _waypointsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Posición ${_waypointsList[index].waypointId}'),
        subtitle: Text(
            'Latitud: ${_waypointsList[index].latitude} - Longitud: ${_waypointsList[index].longitude}'),
      ),
    );
  }
}
