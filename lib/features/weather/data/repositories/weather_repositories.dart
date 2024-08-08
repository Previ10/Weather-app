import 'package:dartz/dartz.dart';
import 'package:weather_app/core/use_case/failure.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repositorie_base.dart';

class WeatherRepositorie extends WeatherRepositorieBase {
  WeatherRepositorie({required super.remote});

  @override
  Future<Either<Failure, WeatherResponse>> fetchWeather(
      double lat, double lon) async {
    try {
      final response = await remote.fetchWeather(lat, lon);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnhandledFailure(message: '$e'));
    }
  }
}
