import 'package:flutter/material.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/core/services/dependencies_imjection_service.dart';
import 'package:weather_app/core/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // darkTheme: darkTheme,
      theme: theme,
      routerConfig: appRouter,
      key: navigatorKey,
      title: 'WEATHER-APP',
      debugShowCheckedModeBanner: false,
    );
  }
}
