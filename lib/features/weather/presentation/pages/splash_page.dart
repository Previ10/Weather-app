import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/core/services/geo_locator_service.dart';
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
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      try {
        Position? position = await _locationService.getCurrentPosition();
        if (position != null) {
          print(
              'Current position: ${position.latitude}, ${position.longitude}');
        }
      } catch (e) {
        print('Error getting location: $e');
      }

      setState(() {});
      _showButtonNotifier.value = true;
    });
  }

  @override
  void dispose() {
    _showButtonNotifier.dispose();
    super.dispose();
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
                          ),
                          onPressed: () => context.go(WeatherPage.routeName),
                          child: Text('Iniciar',
                              style: TextStyle(
                                  color: Palette.backgroundColorScaffold)),
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
