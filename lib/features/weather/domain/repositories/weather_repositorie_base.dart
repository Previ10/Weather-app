import 'package:dartz/dartz.dart';
import 'package:weather_app/core/use_case/failure.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_datasources.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';

abstract class WeatherRepositorieBase {
  final WeatherRemoteDatasourcesBase remote;
  WeatherRepositorieBase({
    required this.remote,
  });
  Future<Either<Failure, WeatherResponse>> fetchWeather(double lat, double lon);
}
