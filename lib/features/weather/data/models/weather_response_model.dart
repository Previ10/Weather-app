import 'package:weather_app/features/weather/data/models/weather_detail_model.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';
import 'package:weather_app/features/weather/data/models/main_model.dart';
import 'package:weather_app/features/weather/data/models/sys_model.dart';

class WeatherResponseModel extends WeatherResponse {
  WeatherResponseModel({
    required super.main,
    required super.sys,
    required super.name,
    required super.country,
    required super.dateTime,
    required super.weatherDetail,
  });

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'sys': sys,
      'name': name,
      'country': country,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      main: MainModel.fromJson(json['main']),
      sys: SysModel.fromJson(json['sys']),
      name: json['name'],
      country: json['sys']['country'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      weatherDetail: (json['weather'] as List<dynamic>)
          .map((item) =>
              WeatherDetailModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
