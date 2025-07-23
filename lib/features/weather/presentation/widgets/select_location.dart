import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/utils/egy_cities.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({
    super.key,
    this.currentWeather,
    this.forecastWeather,
    required this.isCurrent,
  });

  final bool isCurrent;
  final CurrentWeather? currentWeather;
  final ForecastWeather? forecastWeather;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final weatherCubit = context.read<WeatherCubit>();
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return BlocProvider.value(
              value: weatherCubit,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: egyptCities.map((city) {
                  return ListTile(
                    title: Text(city),
                    onTap: () {
                      Navigator.pop(context);
                      isCurrent
                          ? weatherCubit.fetchCurrentWeather(city)
                          : weatherCubit.fetchForecastWeather(city);
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentWeather == null
                ? forecastWeather!.city
                : currentWeather!.city,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.location_on_outlined,
            size: 30,
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
