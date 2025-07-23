import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/ai_suggestion/data/datasource/ai_service.dart';
import 'package:cellula_task/features/ai_suggestion/domain/repositories/weather_suggestion_repository.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:dartz/dartz.dart';

class WeatherSuggestionRepositoryImpl implements WeatherSuggestionRepository {
  final BaseAiDataSource aiService;

  WeatherSuggestionRepositoryImpl(this.aiService);

  @override
  Future<Either<Failure, String>> getSuggestion(
    CurrentWeather currentWeather,
    String userName,
  ) async {
    try {
      final suggestion = await aiService.sendDataToAI(
        weather: currentWeather,
        name: userName,
      );
      return Right(suggestion);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
