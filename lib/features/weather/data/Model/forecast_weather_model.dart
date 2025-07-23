import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';

class ForecastWeatherModel extends ForecastWeather {
  ForecastWeatherModel({
    required super.city,
    required super.date,
    required super.maxTemp,
    required super.minTemp,
    required super.condition,
    required super.icon,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json , String city) {
    return ForecastWeatherModel(
      city: city,
      date: json['date'],
      maxTemp: json['day']['maxtemp_c'],
      minTemp: json['day']['mintemp_c'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
    );
  }

  static List<ForecastWeatherModel> getForecastWeatherListFromJson(
    Map<String, dynamic> json,
  ) {
    final List forecastList = json['forecast']['forecastday'];
    final String cityName = json['location']['name'];
    return forecastList
        .map((dayJson) => ForecastWeatherModel.fromJson(dayJson , cityName))
        .toList();
  }
}
