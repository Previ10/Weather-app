import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/weather/domain/entity/main_from_wather_entity.dart';

class WeatherDetailCardWidget extends StatefulWidget {
  final Size screenSize;
  final Main mainWeather;
  const WeatherDetailCardWidget(
      {super.key, required this.screenSize, required this.mainWeather});

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, size: 30),
                      const SizedBox(height: 5),
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
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.water_drop, size: 30),
                      const SizedBox(height: 5),
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
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, size: 30),
                      const SizedBox(height: 5),
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
              ],
            ),
            Divider(
              height: widget.screenSize.height * 0.1,
              thickness: 3.7,
              color: Palette.mediumGrey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, size: 30),
                      const SizedBox(height: 5),
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
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, size: 30),
                      const SizedBox(height: 5),
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
                SizedBox(width: widget.screenSize.width * 0.1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.thermostat, size: 30),
                      const SizedBox(height: 5),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
