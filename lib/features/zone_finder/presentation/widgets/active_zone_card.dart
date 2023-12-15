import 'package:botanic_visit_guide/config/routes/app_routes.dart';
import 'package:botanic_visit_guide/features/zone_finder/presentation/pages/zone_finder_details.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/zone_data.dart';

class ActiveZoneCard extends StatelessWidget {
  const ActiveZoneCard({
    super.key,
    required this.context,
    required this.zoneData,
    this.imageUrls,
  });

  final BuildContext context;
  final ZoneData zoneData;
  final List<String>? imageUrls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.zoneFinderDetails,
            arguments:
                ZoneFinderDetailsArgs(zoneData: zoneData, imageUrls: imageUrls),
          );
        },
        child: Card(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                imageUrls != null && imageUrls!.isNotEmpty
                    ? Image.network(imageUrls![0],
                        width: 100, height: 100, fit: BoxFit.cover)
                    : const Icon(
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
                        zoneData.zoneName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        zoneData.zoneDescription ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
