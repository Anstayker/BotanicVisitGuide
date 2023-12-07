import 'package:flutter/material.dart';

class ZoneNameTextField extends StatelessWidget {
  const ZoneNameTextField({
    super.key,
    required isFormActive,
  }) : _isFormActive = isFormActive;

  final bool _isFormActive;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: _isFormActive,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Zone Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El nombre de la zona no puede ser vacio';
        }
        return null;
      },
    );
  }
}
