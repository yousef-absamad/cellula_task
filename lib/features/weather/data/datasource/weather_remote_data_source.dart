import 'dart:convert';

import 'package:cellula_task/features/weather/data/Model/forecast_weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:cellula_task/features/weather/data/Model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather(String city);
  Future<List<ForecastWeatherModel>> getForecastWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        'https://api.weatherapi.com/v1/current.json?q=$city&key=f9d72240d3ad4582945121925251707',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CurrentWeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Future<List<ForecastWeatherModel>> getForecastWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?q=$city&days=7&hour=24&key=f9d72240d3ad4582945121925251707',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ForecastWeatherModel.getForecastWeatherListFromJson(jsonData);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
