import 'package:botanic_visit_guide/config/routes/app_routes.dart';

import 'config/theme/app_themes.dart';
import 'package:flutter/material.dart';

import 'features/zone_creator/presentation/pages/zone_visualizer_page.dart';
import 'injection_container.dart' as dependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: defaultTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const ZoneVisualizerPage(),
    );
  }
}
