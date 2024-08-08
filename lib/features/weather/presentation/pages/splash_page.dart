import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/services/geo_locator_service.dart';
import 'package:weather_app/core/services/preferences_service.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/core/utils/images.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ValueNotifier<bool> _showButtonNotifier = ValueNotifier(false);
  late final GeoLocatorService geoLocatorService;
  late Future<SharedPreferences> _prefsFuture;

  @override
  void initState() {
    super.initState();
    geoLocatorService = GeoLocatorService();
    _prefsFuture = SharedPreferences.getInstance();

    _cleanCacheAndStartTimer();
  }

  @override
  void dispose() {
    _showButtonNotifier.dispose();
    super.dispose();
  }

  Future<void> _cleanCacheAndStartTimer() async {
    final prefs = await _prefsFuture;
    final preferencesServices = PreferencesServices(prefs: prefs);

    await preferencesServices.clearAllPreferences();

    Timer(const Duration(seconds: 5), () {
      setState(() {});
      _showButtonNotifier.value = true;
      getCurrentLocation();
    });
  }

  Future<void> getCurrentLocation() async {
    final position = await geoLocatorService.getCurrentPosition();
    final prefs = await _prefsFuture;
    final preferencesServices = PreferencesServices(prefs: prefs);
    await preferencesServices.saveCoordinates(
        position.latitude, position.longitude);
  }

  void navigate() {
    context.go(WeatherPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: _showButtonNotifier,
            builder: (context, showButton, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.all(30),
                    child: Image.asset(
                      Images.weatherSplash,
                      fit: BoxFit.cover,
                      width: screenSize.width,
                      height: screenSize.height * 0.5,
                    ),
                  ),
                  Text(
                    'WEATHER APP',
                    style: GoogleFonts.anton(
                        fontSize: screenSize.width * 0.035,
                        letterSpacing: .6,
                        color: Palette.mediumGrey),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  showButton
                      ? TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Palette.weatherGreen),
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 42.0),
                            ),
                            minimumSize: WidgetStateProperty.all<Size>(
                              Size(screenSize.width * 0.3, 4),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () {
                            navigate();
                          },
                          child: Text(
                            'Iniciar',
                            style: TextStyle(
                              color: Palette.backgroundColorScaffold,
                              fontSize: screenSize.width * 0.03,
                            ),
                          ),
                        )
                      : LoadingAnimationWidget.inkDrop(
                          color: Palette.weatherGreen,
                          size: screenSize.height * 0.05,
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
