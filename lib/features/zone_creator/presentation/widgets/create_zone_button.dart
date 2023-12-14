import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/zone_info.dart';
import '../bloc/bloc.dart';

class CreateZoneButton extends StatelessWidget {
  const CreateZoneButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.context,
    required isFormActive,
    required newZone,
  })  : _formKey = formKey,
        _isFormActive = isFormActive,
        _newZone = newZone;

  final GlobalKey<FormState> _formKey;
  final BuildContext context;
  final bool _isFormActive;
  final ZoneInfo _newZone;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: ElevatedButton(
          onPressed: _isFormActive
              ? () {
                  if (_formKey.currentState!.validate()) {
                    if (_newZone.waypoints.length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Deben haber al menos 3 puntos de referencia en la lista')),
                      );
                    } else {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creando una nueva Zona')),
                      );
                      final newZone = _newZone;
                      BlocProvider.of<ZoneCreatorBloc>(context)
                          .add(AddZoneEvent(zone: newZone, images: []));
                    }
                  }
                }
              : null,
          child: const Text('Crear Zona')),
    );
  }
}
