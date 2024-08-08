import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/core/utils/images.dart';
import 'package:weather_app/features/weather/presentation/manager/bloc/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ValueNotifier<bool> _showButtonNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _requestLocationAndStartTimer();
  }

  @override
  void dispose() {
    _showButtonNotifier.dispose();
    super.dispose();
  }

  Future<void> _requestLocationAndStartTimer() async {
    final geoLocatorProvider =
        Provider.of<GeoLocatorProvider>(context, listen: false);

    await geoLocatorProvider.getCurrentLocation();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showButtonNotifier.value = true;
      });
    });
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
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
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
