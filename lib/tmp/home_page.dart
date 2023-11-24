import 'package:botanic_visit_guide/tmp/notification_page.dart';
import 'package:botanic_visit_guide/tmp/zone_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guia de visita del Jardín Botánico'),
          backgroundColor: Colors.green[600],
          elevation: 0,
        ),
        body: Column(
          children: [
            tabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  paginaDeNotificaciones(),
                  paginaDeZonas(),
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
      color: Colors.green[600], // Color del TabBar
      child: const TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(icon: Icon(Icons.signpost)),
          Tab(icon: Icon(Icons.explore)),
        ],
      ),
    );
  }

  Widget paginaDeNotificaciones() {
    return notificationPage();
  }

  Widget paginaDeZonas() {
    return zonePage();
  }
}
