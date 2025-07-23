import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/utils/get_weather_gradient.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:cellula_task/features/weather/presentation/widgets/icon_widget.dart';
import 'package:cellula_task/features/weather/presentation/widgets/select_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather currentweather;

  const CurrentWeatherCard({super.key, required this.currentweather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20.r),
        gradient: getWeatherGradient(currentweather.condition.toLowerCase()),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectLocation(currentWeather: currentweather, isCurrent: true),
            IconWidget(icon: currentweather.icon),

            const HeightSpace(10),

            Text(
              "${currentweather.temperature}°C",
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const HeightSpace(10),

            Text(
              currentweather.condition,
              style: TextStyle(fontSize: 20.sp, color: AppColors.black),
            ),
            Divider(height: 30.h, color: AppColors.black),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherInfo(
                  icon: Icons.cloud,
                  label: "Cloud",
                  value: currentweather.cloud.toString(),
                ),
                _buildWeatherInfo(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: currentweather.humidity.toString(),
                ),
                _buildWeatherInfo(
                  icon: Icons.air,
                  label: "Wind",
                  value: currentweather.windSpeed.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.secondary),
        const HeightSpace(4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: AppColors.secondary)),
      ],
    );
  }
}
