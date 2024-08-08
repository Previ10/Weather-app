import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_app/core/services/http_service.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_datasources.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repositories.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repositorie_base.dart';
import 'package:weather_app/features/weather/domain/use_cases/fetch_weather_use_cases.dart';
import 'package:weather_app/features/weather/presentation/manager/bloc/weather_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // REGISTRO DE CLIENTE HTTP:
  getIt.registerSingleton<Client>(Client());
// REGISTRO DE SERVICIO HTTP:
  getIt.registerSingleton<HttpServiceBase>(
      HttpService(httpClient: getIt<Client>()));
// REGISTRO DE FUENTES DE DATOS:
  getIt.registerSingleton<WeatherRemoteDatasourcesBase>(
      WeatherRemoteDatasources(http: getIt<HttpServiceBase>()));
  //REGISTRO DE REPOSITORIO:
  getIt.registerSingleton<WeatherRepositorieBase>(
      WeatherRepositorie(remote: getIt()));
  // REGISTRO DE CASOS DE USO:
  getIt.registerSingleton<FetchWeatherResponseUseCase>(
      FetchWeatherResponseUseCase(repository: getIt<WeatherRepositorieBase>()));
  // REGISTRO DE BLOC:
  getIt.registerSingleton<WeatherBloc>(WeatherBloc(
      fetchWeatherResponseUseCase: getIt<FetchWeatherResponseUseCase>()));
}
