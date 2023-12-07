import 'package:flutter/material.dart';

import 'notification_details.dart';

Widget notificationPage(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.notifications,
                size: 24.0,
              ),
              SizedBox(width: 16.0),
              Text(
                'Zona activa',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        activeZone(context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 24.0,
              ),
              SizedBox(width: 16.0),
              Text(
                'Zonas encontradas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        zoneNotificationCard('Planta 1', 'Descripción de la zona 1', context),
        zoneNotificationCard('Planta 2', 'Descripción de la zona 2', context),
        zoneNotificationCard('Planta 3', 'Descripción de la zona 3', context),
      ],
    ),
  );
}

Widget activeZone(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NotificationDetailsPage()),
        );
      },
      child: Card(
        color: Colors.grey[100],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.image, // Icono que representa la imagen
                size: 100.0, // Tamaño del icono
              ),
              SizedBox(width: 16.0), // Espacio entre el icono y el texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de la planta',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Subtítulo con descripcion de la planta y de la zona',
                      style: TextStyle(fontSize: 16),
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

Widget zoneNotificationCard(
    String zoneName, String zoneDescription, BuildContext context) {
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotificationDetailsPage()),
          );
        },
      ),
    ),
  );
}
