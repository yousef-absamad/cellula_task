import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/domain/Repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetForecastWeatherUseCase {
  final WeatherRepository repository;

  GetForecastWeatherUseCase(this.repository);

  Future<Either<Failure, List<ForecastWeather>>> call(String cityName) {
    return repository.getForecastWeather(cityName);
  }
}
