import 'package:botanic_visit_guide/features/zone_creator/presentation/pages/zone_creator_page.dart';
import 'package:botanic_visit_guide/features/zone_creator/presentation/pages/zone_visualizer_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const zoneCreator = '/ZoneCreator';
  static const zoneVisualizer = '/ZoneVisualizer';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _materialRoute(const ZoneVisualizerPage());
      case zoneCreator:
        return _materialRoute(const ZoneCreatorPage());
      case zoneVisualizer:
        return _materialRoute(const ZoneVisualizerPage());
      default:
        return _materialRoute(const ZoneVisualizerPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
