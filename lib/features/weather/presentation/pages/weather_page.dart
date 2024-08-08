import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/services/dependencies_imjection_service.dart';
import 'package:weather_app/core/services/geo_locator_service.dart';
import 'package:weather_app/core/services/preferences_service.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/weather/data/models/weather_response_model.dart';
import 'package:weather_app/features/weather/presentation/manager/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_animation_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_detail_card_widget.dart';

class WeatherPage extends StatefulWidget {
  static const routeName = '/weather';

  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherBloc weatherBloc = getIt();
  late Size screenSize;
  WeatherResponseModel? weatherResponseModel;
  bool isLoading = true;
  bool isError = false;
  final int timezoneOffset = 7200;
  late StreamSubscription<Position> _positionSubscription;
  late final GeoLocatorService geoLocatorService;

  @override
  void initState() {
    super.initState();
    geoLocatorService = GeoLocatorService();
    _fetchCoordinatesAndWeather();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    super.dispose();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No coordinates found in local storage'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _fetchCoordinatesAndWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final preferencesServices = PreferencesServices(prefs: prefs);
    final coordinates = await preferencesServices.getCoordinates();

    if (coordinates != null) {
      final latitude = coordinates['latitude']!;
      final longitude = coordinates['longitude']!;
      weatherBloc.add(ActionFetchWeather(latitude, longitude));
    } else {}
  }

  Future<void> updateLocation() async {
    setState(() {});

    final position = await geoLocatorService.getCurrentPosition();
    weatherBloc.add(ActionFetchWeather(position.latitude, position.longitude));
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.lightBlue, Palette.clearWhite],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocListener<WeatherBloc, WeatherState>(
          bloc: weatherBloc,
          listener: (context, state) {
            if (state is OnFetchWeatherSuccess) {
              setState(() {
                weatherResponseModel =
                    state.weatherResponse as WeatherResponseModel?;
                isLoading = false;
                isError = false;
              });
            } else if (state is OnLoading) {
              setState(() {
                isLoading = true;
                isError = false;
              });
            } else if (state is OnFetchWeatherFailure) {
              setState(() {
                isLoading = false;
                isError = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to fetch weather data')),
              );
            }
          },
          child: Center(
            child: isLoading
                ? LoadingAnimationWidget.inkDrop(
                    color: Palette.weatherGreen,
                    size: screenSize.height * 0.09,
                  )
                : isError
                    ? const Text('Something went wrong!')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                            duration: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  size: screenSize.height * 0.03,
                                  color: Palette.mediumGrey,
                                ),
                                Text(
                                  weatherResponseModel!.name,
                                  style: GoogleFonts.anton(
                                    fontSize: screenSize.width * 0.035,
                                    letterSpacing: .6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeIn(
                            duration: const Duration(seconds: 1),
                            child: Text(
                              '${weatherResponseModel!.main.temp}°C',
                              style: TextStyle(
                                  color: Palette.softGrey,
                                  fontSize: screenSize.width * 0.1,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          FadeIn(
                            duration: const Duration(seconds: 1),
                            child: Text(
                              '${weatherResponseModel!.dateTime}',
                              style: GoogleFonts.meeraInimai(
                                fontSize: screenSize.width * 0.030,
                                letterSpacing: .6,
                              ),
                            ),
                          ),
                          FadeIn(
                            duration: const Duration(seconds: 1),
                            child: WeatherAnimationWidget(
                              weatherDetail:
                                  weatherResponseModel!.weatherDetail[0],
                              screenSize: screenSize,
                              weatherCondition:
                                  weatherResponseModel!.weatherDetail.isNotEmpty
                                      ? weatherResponseModel!
                                          .weatherDetail.first.main
                                      : 'Clear',
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          FadeIn(
                            duration: const Duration(seconds: 1),
                            child: WeatherDetailCardWidget(
                              mainWeather: weatherResponseModel!.main,
                              screenSize: screenSize,
                              weatherResponseModel: weatherResponseModel!,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          IconButton(
                              color: Palette.softBlue,
                              iconSize: screenSize.width * 0.07,
                              onPressed: () {
                                _fetchCoordinatesAndWeather();
                              },
                              icon: const Icon(
                                Icons.replay,
                              )),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
