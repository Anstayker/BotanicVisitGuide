import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';
import 'package:botanic_visit_guide/features/zone_creator/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/waypoint.dart';

class CreateZoneButton extends StatelessWidget {
  const CreateZoneButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required List<Waypoint> waypointsList,
    required this.context,
    required isFormActive,
  })  : _formKey = formKey,
        _waypointsList = waypointsList,
        _isFormActive = isFormActive;

  final GlobalKey<FormState> _formKey;
  final List<Waypoint> _waypointsList;
  final BuildContext context;
  final bool _isFormActive;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: ElevatedButton(
          onPressed: _isFormActive
              ? () {
                  if (_formKey.currentState!.validate()) {
                    if (_waypointsList.length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Deben haber al menos 3 puntos de referencia en la lista')),
                      );
                    } else {
                      final newZone = ZoneInfo(
                          zoneId: 1, name: 'name', waypoints: _waypointsList);
                      BlocProvider.of<ZoneCreatorBloc>(context)
                          .add(AddZoneEvent(zone: newZone));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creando Zona')),
                      );
                    }
                  }
                }
              : null,
          child: const Text('Crear Zona')),
    );
  }
}
