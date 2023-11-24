import 'package:botanic_visit_guide/tmp/zone_creator_page.dart';
import 'package:flutter/material.dart';

Widget zonePage(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 24.0,
              ),
              SizedBox(width: 16.0),
              Text(
                'Zonas disponibles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        zoneList('Zona 1', 'description de la zona y de las plantas', context),
        zoneList('Zona 2', 'description de la zona y de las plantas', context),
        zoneList('Zona 3', 'description de la zona y de las plantas', context),
        zoneList('Zona 4', 'description de la zona y de las plantas', context),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ZoneCreatorPage()),
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
    ),
  );
}

Widget zoneList(String name, String description, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Card(
      color: Colors.grey[100],
      child: ExpansionTile(
        title: Text(name),
        subtitle: Text(description),
        children: <Widget>[
          expansionTileContent('Waipoint 1'),
          expansionTileContent('Waipoint 2'),
          expansionTileContent('Waipoint 3'),
          expansionTileContent('Waipoint 4')
        ],
      ),
    ),
  );
}

Widget expansionTileContent(String name) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(name),
          const Text('Latitud: 0.0000000'),
          const Text('Longitud: 0.0000000'),
        ]),
  );
}
