import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/request_state.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_cubit.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:cellula_task/features/weather/domain/Entity/forecast_weather.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_cubit.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_state.dart';
import 'package:cellula_task/features/weather/presentation/widgets/ai_suggestion.dart';
import 'package:cellula_task/features/weather/presentation/widgets/error_with_retry.dart';
import 'package:cellula_task/features/weather/presentation/widgets/forecast_card.dart';
import 'package:cellula_task/features/weather/presentation/widgets/select_location.dart';
import 'package:cellula_task/features/weather/presentation/widgets/user_profile_header.dart';
import 'package:cellula_task/features/weather/presentation/widgets/current_weather_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherScreen extends StatelessWidget {
  final UserEntity userEntity;
  const WeatherScreen({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.black, AppColors.backgroundEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                UserProfileHeader(userEntity: userEntity),
                const HeightSpace(50),
                BlocBuilder<WeatherCubit, WeatherState>(
                  buildWhen: (previous, current) =>
                      previous.forecastWeatherStatus !=
                      current.forecastWeatherStatus,
                  builder: (context, state) {
                    if (state.forecastWeatherStatus == RequestStatus.loading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    } else if (state.forecastWeatherStatus ==
                        RequestStatus.loaded) {
                      final List<ForecastWeather> forecastList =
                          state.forecastWeather!;
                      return Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Column(
                          children: [
                            SelectLocation(
                              forecastWeather: forecastList[0],
                              isCurrent: false,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: forecastList.length,
                                itemBuilder: (context, index) {
                                  return ForecastCard(
                                    forecast: forecastList[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state.forecastWeatherStatus ==
                        RequestStatus.error) {
                      return ErrorWithRetry(
                        height: 0.25,
                        errorMessage: state.forecastWeatherError!,
                        onPressed: () {
                          context.read<WeatherCubit>().fetchForecastWeather(
                            "Cairo",
                          );
                        },
                      );
                    }
                    return Center();
                  },
                ),
                HeightSpace(30),
                BlocConsumer<WeatherCubit, WeatherState>(
                  buildWhen: (previous, current) =>
                      previous.currentWeatherStatus !=
                      current.currentWeatherStatus,
                  listenWhen: (previous, current) =>
                      previous.currentWeatherStatus !=
                      current.currentWeatherStatus,
                  listener: (context, state) {
                    if (state.currentWeatherStatus == RequestStatus.loaded) {
                      context.read<SuggestionCubit>().getSuggestion(
                        state.currentWeather!,
                        userEntity.name,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.currentWeatherStatus == RequestStatus.loading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    } else if (state.currentWeatherStatus ==
                        RequestStatus.loaded) {
                      final weather = state.currentWeather;
                      return CurrentWeatherCard(currentweather: weather!);
                    } else if (state.currentWeatherStatus ==
                        RequestStatus.error) {
                      return ErrorWithRetry(
                        height: 0.5,
                        errorMessage: state.currentWeatherError!,
                        onPressed: () {
                          context.read<WeatherCubit>().fetchCurrentWeather(
                            "Cairo",
                          );
                          context.read<SuggestionCubit>().getSuggestion(
                            state.currentWeather!,
                            userEntity.name,
                          );
                        },
                      );
                    } else {
                      return Center();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AISuggestion(),
      ),
    );
  }
}
