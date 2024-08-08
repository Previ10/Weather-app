import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/weather/presentation/pages/splash_page.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: SplashPage.routeName,
  routes: [
    GoRoute(
      path: WeatherPage.routeName,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const WeatherPage(),
      ),
    ),
    GoRoute(
      path: SplashPage.routeName,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const SplashPage(),
      ),
    ),
  ],
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.go(WeatherPage.routeName);
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Error: ${state.error.toString()}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  },
);
CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
