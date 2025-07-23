import 'package:cellula_task/core/services/request_state.dart';
import 'package:cellula_task/features/weather/domain/usecase/get_forecast_weather_use_case.dart';
import 'package:cellula_task/features/weather/domain/usecase/get_current_weather_use_case.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUseCase getWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  WeatherCubit(this.getWeatherUseCase, this.getForecastWeatherUseCase)
    : super(WeatherState());

  Future<void> fetchCurrentWeather(String city) async {
    emit(state.copyWith(currentWeatherStatus: RequestStatus.loading));
    final result = await getWeatherUseCase(city);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            currentWeatherStatus: RequestStatus.error,
            currentWeatherError: 'Failed to fetch current weather',
          ),
        );
      },
      (weather) {
        emit(
          state.copyWith(
            currentWeatherStatus: RequestStatus.loaded,
            currentWeather: weather,
          ),
        );
      },
    );
  }

  Future<void> fetchForecastWeather(String city) async {
    emit(state.copyWith(forecastWeatherStatus: RequestStatus.loading));
    final result = await getForecastWeatherUseCase(city);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            forecastWeatherStatus: RequestStatus.error,
            forecastWeatherError: 'Failed to fetch forecast weather',
          ),
        );
      },
      (forecastWeather) {
        emit(
          state.copyWith(
            forecastWeatherStatus: RequestStatus.loaded,
            forecastWeather: forecastWeather,
          ),
        );
      },
    );
  }
}
