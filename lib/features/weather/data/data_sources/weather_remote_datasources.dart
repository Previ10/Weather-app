import 'package:weather_app/core/services/http_service.dart';
import 'package:weather_app/features/weather/data/models/weather_response_model.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';

abstract class WeatherRemoteDatasourcesBase {
  Future<WeatherResponse> fetchWeather(double lat, double lon);
}

class WeatherRemoteDatasources implements WeatherRemoteDatasourcesBase {
  final HttpServiceBase http;
  final String apiKey = '96a12fa525000af9043e52785c07fa1f';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherRemoteDatasources({required this.http});

  @override
  Future<WeatherResponse> fetchWeather(double lat, double lon) async {
    try {
      final url = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
      final response = await http.get(url: url);
      print(response.toString());

      final weatherResponse = WeatherResponseModel.fromJson(response);
      return weatherResponse;
    } catch (e) {
      throw Exception('Error al obtener el clima: $e');
    }
  }
}
