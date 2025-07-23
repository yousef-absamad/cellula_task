class CurrentWeather {
  final double temperature;
  final String condition;
  final int cloud;
  final double windSpeed;
  final int humidity;
  final String icon;
  final String city;
  final String country;

  CurrentWeather({
    required this.temperature,
    required this.condition,
    required this.cloud,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.city,
    required this.country,
  });
}
