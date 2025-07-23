import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/ai_suggestion/domain/repositories/weather_suggestion_repository.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:dartz/dartz.dart';

class GetWeatherSuggestionUseCase {
  final WeatherSuggestionRepository repository;

  GetWeatherSuggestionUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required CurrentWeather currentWeather,
    required String userName,
  }) {
    return repository.getSuggestion(currentWeather, userName);
  }
}
