import 'package:flutter/material.dart';

LinearGradient getWeatherGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return LinearGradient(
          colors: [Colors.orange.shade300, Colors.yellow.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'rain':
      case 'shower':
        return LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'cloudy':
      case 'partly cloudy':
        return LinearGradient(
          colors: [Colors.grey.shade400, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [Colors.blueGrey.shade300, Colors.blueGrey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }