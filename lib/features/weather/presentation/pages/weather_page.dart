import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/core/services/dependencies_imjection_service.dart';
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

  @override
  void initState() {
    weatherBloc.add(const ActionFetchWeather(-31.4135, -64.18105));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    DateTime utcNow = DateTime.now().toUtc();
    DateTime localTime = utcNow.add(Duration(seconds: timezoneOffset));
    String formattedTime = DateFormat('yyyy/MM/dd - hh:mm').format(localTime);

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
                    size: screenSize.height * 0.05,
                  )
                : isError
                    ? const Text('Something went wrong!')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
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
                          const SizedBox(height: 20),
                          Text(
                            '${weatherResponseModel!.main.temp} °C',
                            style: TextStyle(
                                fontSize: screenSize.width * 0.1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formattedTime,
                            style: GoogleFonts.meeraInimai(
                              fontSize: screenSize.width * 0.030,
                              letterSpacing: .6,
                            ),
                          ),
                          WeatherAnimationWidget(
                            weatherDetail:
                                weatherResponseModel!.weatherDetail[0],
                            screenSize: screenSize,
                            weatherCondition: weatherResponseModel!
                                    .weatherDetail.isNotEmpty
                                ? weatherResponseModel!.weatherDetail.first.main
                                : 'Clear',
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          WeatherDetailCardWidget(
                            mainWeather: weatherResponseModel!.main,
                            screenSize: screenSize,
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
