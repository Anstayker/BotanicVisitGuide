import 'package:flutter/material.dart';

Widget zonePage() {
  return Scaffold(
    backgroundColor: Colors.green[100],
    body: const Center(
      child: Text(
        'Página 2',
        style: TextStyle(fontSize: 32, color: Colors.black),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Acción al presionar el botón
      },
      child: const Icon(Icons.add),
      backgroundColor: Colors.green,
    ),
  );
}
