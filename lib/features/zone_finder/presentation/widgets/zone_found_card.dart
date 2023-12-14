import 'package:botanic_visit_guide/features/zone_finder/domain/entities/zone_data.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../pages/zone_finder_details.dart';

class ZoneFoundCard extends StatelessWidget {
  const ZoneFoundCard({
    super.key,
    required this.context,
    required this.zoneData,
  });

  final ZoneData zoneData;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        color: Colors.grey[100],
        child: ListTile(
          leading: const Icon(Icons.forest, color: Colors.grey),
          title: Text(
            zoneData.zoneName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            zoneData.zoneDescription ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.zoneFinderDetails,
                arguments: ZoneFinderDetailsArgs(zoneData: zoneData));
          },
        ),
      ),
    );
  }
}
