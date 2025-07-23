class ForecastWeather {
  final String city;
  final String date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  ForecastWeather({
    required this.city,
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
  });
}
