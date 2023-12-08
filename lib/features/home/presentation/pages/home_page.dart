import 'package:flutter/material.dart';

import '../../../zone_creator/presentation/pages/zone_visualizer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(appBar: _homeAppBar(context), body: _homeBody()));
  }

  PreferredSizeWidget _homeAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Guia de visita del Jardín Botánico'),
      bottom: _buildTabBar(context),
    );
  }

  Widget _homeBody() {
    return _buildTabView();
  }

  Widget _buildTabView() {
    return TabBarView(
      children: [Container(), const ZoneVisualizerPage()],
    );
  }

  PreferredSizeWidget _buildTabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
      tabs: const [
        Tab(icon: Icon(Icons.signpost)),
        Tab(icon: Icon(Icons.explore))
      ],
    );
  }
}
