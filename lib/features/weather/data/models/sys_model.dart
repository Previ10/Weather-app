import 'package:weather_app/features/weather/domain/entity/sys_from_weather_entity.dart';

class SysModel extends Sys {
  SysModel({
    required super.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'country': country,
    };
  }

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      country: json['country'],
    );
  }
}
