import 'package:flutter/material.dart';

class ActiveZoneCard extends StatelessWidget {
  const ActiveZoneCard({
    super.key,
    required this.context,
    required this.title,
    this.subtitle,
  });

  final BuildContext context;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          color: Colors.grey[100],
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.image, // Icono que representa la imagen
                  size: 100.0, // Tamaño del icono
                ),
                const SizedBox(
                    width: 16.0), // Espacio entre el icono y el texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
