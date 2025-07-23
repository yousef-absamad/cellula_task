// import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
// import 'package:cellula_task/features/weather/domain/Entity/weather.dart';

// abstract class WeatherState {}

// class WeatherInitial extends WeatherState {}

// class CurrentWeatherLoading extends WeatherState {}

// class CurrentWeatherLoaded extends WeatherState {
//   final CurrentWeather weather;

//   CurrentWeatherLoaded(this.weather);
// }

// class CurrentWeatherError extends WeatherState {
//   final String message;

//   CurrentWeatherError(this.message);
// }

// class ForecastWeatherLoading extends WeatherState {}

// class ForecastWeatherLoaded extends WeatherState {
//   final List<ForecastWeather> forecastWeather;

//   ForecastWeatherLoaded(this.forecastWeather);
// }

// class ForecastWeatherError extends WeatherState {
//   final String message;

//   ForecastWeatherError(this.message);
// }

import 'package:cellula_task/core/services/request_state.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';

class WeatherState {
  final CurrentWeather? currentWeather;
  final List<ForecastWeather>? forecastWeather;
  final RequestStatus? currentWeatherStatus;
  final RequestStatus? forecastWeatherStatus;
  final String? currentWeatherError;
  final String? forecastWeatherError;

  WeatherState({
    this.currentWeather,
    this.forecastWeather,
    this.currentWeatherStatus = RequestStatus.loading,
    this.forecastWeatherStatus = RequestStatus.loading,
    this.currentWeatherError,
    this.forecastWeatherError,
  });

  WeatherState copyWith({
    CurrentWeather? currentWeather,
    List<ForecastWeather>? forecastWeather,
    RequestStatus? currentWeatherStatus,
    RequestStatus? forecastWeatherStatus,
    String? currentWeatherError,
    String? forecastWeatherError,
  }) {
    return WeatherState(
      currentWeather: currentWeather ?? this.currentWeather,
      forecastWeather: forecastWeather ?? this.forecastWeather,
      currentWeatherStatus: currentWeatherStatus ?? this.currentWeatherStatus,
      forecastWeatherStatus:
          forecastWeatherStatus ?? this.forecastWeatherStatus,
      currentWeatherError: currentWeatherError ?? this.currentWeatherError,
      forecastWeatherError: forecastWeatherError ?? this.forecastWeatherError,
    );
  }
}
