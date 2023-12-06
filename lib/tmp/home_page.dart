import 'package:flutter/material.dart';

import 'notification_page.dart';
import 'zone_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guia de visita del Jardín Botánico'),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: Column(
          children: [
            tabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  notificationPage(context),
                  zonePage(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return Container(
      color: Colors.green, // Color del TabBar
      child: const TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(icon: Icon(Icons.signpost)),
          Tab(icon: Icon(Icons.explore)),
        ],
      ),
    );
  }
}
