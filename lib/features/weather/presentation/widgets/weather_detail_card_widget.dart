import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/weather/data/models/weather_response_model.dart';
import 'package:weather_app/features/weather/domain/entity/main_from_wather_entity.dart';

class WeatherDetailCardWidget extends StatefulWidget {
  final Size screenSize;
  final Main mainWeather;
  final WeatherResponseModel weatherResponseModel;
  const WeatherDetailCardWidget(
      {super.key,
      required this.screenSize,
      required this.mainWeather,
      required this.weatherResponseModel});

  @override
  State<WeatherDetailCardWidget> createState() =>
      _WeatherDetailCardWidgetState();
}

class _WeatherDetailCardWidgetState extends State<WeatherDetailCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 120),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.line_weight, size: 30),
                        Text(
                          'Pressure: ${widget.mainWeather.pressure} hPa',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.water_drop, size: 30),
                        Text(
                          'Humidity: ${widget.mainWeather.humidity}%',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.waves, size: 30),
                        Text(
                          'Sea Lvl:  ${widget.mainWeather.sealevel} m',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FadeIn(
              duration: const Duration(seconds: 1),
              child: Divider(
                height: widget.screenSize.height * 0.08,
                thickness: 3.7,
                color: Palette.mediumGrey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.thermostat, size: 30),
                        Text(
                          'Max: ${widget.mainWeather.tempMax} °C',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.thermostat, size: 30),
                        Text(
                          'Min: ${widget.mainWeather.tempMin} °C',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.thermostat_outlined, size: 30),
                        Text(
                          'TC:   ${widget.mainWeather.feelsLike} °C',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.meeraInimai(
                            fontSize: widget.screenSize.width * 0.030,
                            letterSpacing: .6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
