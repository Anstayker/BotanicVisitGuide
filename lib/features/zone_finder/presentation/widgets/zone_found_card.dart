import 'package:flutter/material.dart';

class ZoneFoundCard extends StatelessWidget {
  const ZoneFoundCard({
    super.key,
    required this.zoneName,
    required this.zoneDescription,
    required this.context,
  });

  final String zoneName;
  final String zoneDescription;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        color: Colors.grey[100],
        child: ListTile(
          leading: const Icon(Icons.forest, color: Colors.grey),
          title: Text(zoneName),
          subtitle: Text(
            zoneDescription,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }
}
