part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class OnLoading extends WeatherState {}

class OnFetchWeatherSuccess extends WeatherState {
  final WeatherResponse weatherResponse;

  const OnFetchWeatherSuccess(this.weatherResponse);

  @override
  List<Object> get props => [weatherResponse];
}

class OnFetchWeatherFailure extends WeatherState {
  final Failure failure;

  const OnFetchWeatherFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
