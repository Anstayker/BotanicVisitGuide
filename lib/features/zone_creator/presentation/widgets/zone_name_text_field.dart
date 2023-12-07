import 'package:flutter/material.dart';

class ZoneNameTextField extends StatelessWidget {
  const ZoneNameTextField(
      {super.key,
      required isFormActive,
      required this.onSaved,
      required zoneNameController})
      : _isFormActive = isFormActive,
        _zoneNameController = zoneNameController;

  final bool _isFormActive;
  final Function(String?) onSaved;
  final TextEditingController _zoneNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _zoneNameController,
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
      onSaved: onSaved,
    );
  }
}
