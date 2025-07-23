import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherSuggestionRepository {
  Future<Either<Failure, String>> getSuggestion(
    CurrentWeather currentWeather,
    String userName,
  );
}
