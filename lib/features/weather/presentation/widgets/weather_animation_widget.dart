import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/utils/animations.dart';
import 'package:weather_app/features/weather/domain/entity/weather_detail_entity.dart';

class WeatherAnimationWidget extends StatelessWidget {
  final Size screenSize;
  final String weatherCondition;
  final WeatherDetail weatherDetail;

  const WeatherAnimationWidget({
    super.key,
    required this.weatherCondition,
    required this.screenSize,
    required this.weatherDetail,
  });

  String _getAnimationPath(String condition, String description) {
    switch (condition) {
      case 'Clear':
        return Animations.sunAnimation;
      case 'Clouds':
        if (description.contains('few clouds')) {
          return Animations.cloudSunAnimation;
        } else if (description.contains('scattered clouds')) {
          return Animations.cloudSunAnimation;
        } else if (description.contains('broken clouds')) {
          return Animations.cloudSunAnimation;
        } else if (description.contains('overcast clouds')) {
          return Animations.cloudAnimation;
        } else {
          return Animations.cloudAnimation;
        }
      case 'Rain':
        return Animations.cloudRainAnimation;
      case 'Thunderstorm':
        return Animations.cloudThunderAnimatkion;
      case 'Snow':
        return Animations.cloudAnimation;
      case 'Mist':
        return Animations.cloudAnimation;
      default:
        return Animations.cloudAnimation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationPath =
        _getAnimationPath(weatherCondition, weatherDetail.description);

    return Column(
      children: [
        Lottie.asset(animationPath),
        Text(
          weatherDetail.description,
          style: GoogleFonts.meeraInimai(
            fontSize: screenSize.width * 0.030,
            letterSpacing: .6,
          ),
        ),
      ],
    );
  }
}
