import 'package:weather_app/features/weather/domain/entity/main_from_wather_entity.dart';

class MainModel extends Main {
  MainModel({
    required super.temp,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    required super.feelsLike,
    required super.sealevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      temp: json['temp'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      feelsLike: json['feels_like'].toDouble(),
      sealevel: json['sea_level'],
    );
  }
}
