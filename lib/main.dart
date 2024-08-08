import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/core/services/dependencies_imjection_service.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/weather/presentation/manager/bloc/provider/weather_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) {
        return GeoLocatorProvider();
      }),
    ], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      routerConfig: appRouter,
      key: navigatorKey,
      title: 'WEATHER-APP',
      debugShowCheckedModeBanner: false,
    );
  }
}
