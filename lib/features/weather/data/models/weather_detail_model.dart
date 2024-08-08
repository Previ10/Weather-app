import 'package:weather_app/features/weather/domain/entity/weather_detail_entity.dart';

class WeatherDetailModel extends WeatherDetail {
  WeatherDetailModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherDetailModel.fromJson(Map<String, dynamic> json) {
    return WeatherDetailModel(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}
