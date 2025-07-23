import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/utils/get_weather_gradient.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/presentation/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatelessWidget {
  final ForecastWeather forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat(
      'EEEE, MMM d',
    ).format(DateTime.parse(forecast.date));

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          gradient: getWeatherGradient(forecast.condition),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150.w,
                child: Text(
                  dateFormatted,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const HeightSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(icon: forecast.icon),
                  WidthSpace(12),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      forecast.condition,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),

              const HeightSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTempDisplay(
                    'Max',
                    '${forecast.maxTemp}°C',
                    Icons.arrow_upward,
                  ),
                  _buildTempDisplay(
                    'Min',
                    '${forecast.minTemp}°C',
                    Icons.arrow_downward,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTempDisplay(String label, String temp, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.black),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            ),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
