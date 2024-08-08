import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/use_cases/fetch_weather_use_cases.dart';
import 'package:weather_app/core/use_case/failure.dart';
import 'package:weather_app/features/weather/domain/entity/weather_response_entity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherResponseUseCase fetchWeatherResponseUseCase;

  WeatherBloc({required this.fetchWeatherResponseUseCase})
      : super(WeatherInitial()) {
    on<ActionFetchWeather>(_fetchWeather);
  }

  Future<void> _fetchWeather(
    ActionFetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(OnLoading());

    final result =
        await fetchWeatherResponseUseCase.call(Tuple2(event.lat, event.lon));

    result.fold(
      (failure) => emit(OnFetchWeatherFailure(failure)),
      (weatherResponse) => emit(OnFetchWeatherSuccess(weatherResponse)),
    );
  }
}
