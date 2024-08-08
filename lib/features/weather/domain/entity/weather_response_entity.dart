import 'package:weather_app/features/weather/domain/entity/main_from_wather_entity.dart';
import 'package:weather_app/features/weather/domain/entity/sys_from_weather_entity.dart';
import 'package:weather_app/features/weather/domain/entity/weather_detail_entity.dart';

class WeatherResponse {
  final Main main;
  final Sys sys;
  final String name;
  final String country;
  final DateTime dateTime;
  final List<WeatherDetail> weatherDetail;

  WeatherResponse({
    required this.main,
    required this.sys,
    required this.name,
    required this.country,
    required this.dateTime,
    required this.weatherDetail,
  });
}
