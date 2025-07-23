import 'package:cellula_task/features/weather/domain/Entity/weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  CurrentWeatherModel({
    required super.temperature,
    required super.condition,
    required super.cloud,
    required super.humidity,
    required super.windSpeed,
    required super.icon,
    required super.city,
    required super.country,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      cloud: json['current']['cloud'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_kph'],
      icon: json['current']['condition']['icon'] ?? '',
      city: json['location']['name'] ?? '',
      country: json['location']['country'] ?? '',
    );
  }
}
