import 'package:botanic_visit_guide/features/zone_finder/presentation/pages/zone_finder_details.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/zone_creator/presentation/pages/zone_creator_page.dart';
import '../../features/zone_creator/presentation/pages/zone_visualizer_page.dart';

class AppRoutes {
  static const home = '/';
  static const zoneCreator = '/ZoneCreator';
  static const zoneVisualizer = '/ZoneVisualizer';
  static const zoneFinderDetails = '/ZoneFinderDetails';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _materialRoute(const HomePage());
      case zoneCreator:
        return _materialRoute(const ZoneCreatorPage());
      case zoneVisualizer:
        return _materialRoute(const ZoneVisualizerPage());
      case zoneFinderDetails:
        final ZoneFinderDetailsArgs args =
            settings.arguments as ZoneFinderDetailsArgs;
        return _materialRoute(ZoneFinderDetailsPage(args: args));
      default:
        return _materialRoute(const ZoneVisualizerPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
