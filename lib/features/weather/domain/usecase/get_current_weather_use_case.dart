import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:cellula_task/features/weather/domain/Repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  Future<Either<Failure, CurrentWeather>> call(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
