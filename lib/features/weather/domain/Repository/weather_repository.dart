import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(String city);
  Future<Either<Failure, List<ForecastWeather>>> getForecastWeather(String city);
}
