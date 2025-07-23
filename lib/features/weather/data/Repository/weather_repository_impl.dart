import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:cellula_task/features/weather/domain/Repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(String city) async {
    try {
      final weatherModel = await remoteDataSource.getCurrentWeather(city);
      return Right(weatherModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ForecastWeather>>> getForecastWeather(
    String city,
  ) async {
    try {
      final forecastWeather = await remoteDataSource.getForecastWeather(city);
      return Right(forecastWeather);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
