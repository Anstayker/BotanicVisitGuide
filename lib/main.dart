import 'package:flutter/material.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/app_themes.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'injection_container.dart' as dependencies;

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const HomePage(),
    );
  }
}
