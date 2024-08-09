import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/services/dependencies_imjection_service.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/weather/data/models/weather_response_model.dart';
import 'package:weather_app/features/weather/presentation/manager/bloc/provider/weather_provider.dart';
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

  @override
  void initState() {
    super.initState();

    final geoLocatorProvider =
        Provider.of<GeoLocatorProvider>(context, listen: false);

    geoLocatorProvider.getCurrentLocation().then((_) {
      if (geoLocatorProvider.latitude != null &&
          geoLocatorProvider.longitude != null) {
        weatherBloc.add(
          ActionFetchWeather(
            geoLocatorProvider.latitude!,
            geoLocatorProvider.longitude!,
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
        showScaffoldMessage();
      }
    });
  }

  void showScaffoldMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to get location coordinates')),
    );
  }

  @override
  void dispose() {
    weatherBloc.close();
    super.dispose();
  }

  Future<void> updateLocation() async {
    setState(() {});
    final geoLocatorProvider =
        Provider.of<GeoLocatorProvider>(context, listen: false);

    await geoLocatorProvider.getCurrentLocation();
    weatherBloc.add(
      ActionFetchWeather(
        geoLocatorProvider.latitude!,
        geoLocatorProvider.longitude!,
      ),
    );
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
                            duration: const Duration(seconds: 1100),
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
                            duration: const Duration(milliseconds: 1200),
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
                            duration: const Duration(milliseconds: 1300),
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
                            duration: const Duration(milliseconds: 1500),
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
                                updateLocation();
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
