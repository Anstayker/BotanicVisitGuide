import 'package:flutter/material.dart';

class ZoneCreatorPage extends StatelessWidget {
  const ZoneCreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear zona'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Text('ZoneCreatorPage'),
      ),
    );
  }
}
