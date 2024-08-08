import 'package:dartz/dartz.dart';
import 'package:weather_app/core/use_case/failure.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repositorie_base.dart';
import 'package:weather_app/core/use_case/use_case_base.dart';

class FetchWeatherResponseUseCase
    extends UseCaseBase<WeatherResponse, Tuple2<double, double>> {
  final WeatherRepositorieBase repository;

  FetchWeatherResponseUseCase({required this.repository});

  @override
  Future<Either<Failure, WeatherResponse>> call(
      Tuple2<double, double> params) async {
    final lat = params.value1;
    final lon = params.value2;

    return await repository.fetchWeather(lat, lon);
  }
}
