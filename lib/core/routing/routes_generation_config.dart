import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/services_locator.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_cubit.dart';
import 'package:cellula_task/features/weather/presentation/screens/weather_screen.dart';
import 'package:cellula_task/splash_screen.dart';
import 'package:cellula_task/features/auth/presentation/screens/login_screen.dart';
import 'package:cellula_task/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerationConfig {
  static GoRouter goRoute = GoRouter(
    // initialLocation: FirebaseAuth.instance.currentUser == null
    //     ? AppRoutes.loginScreen
    //     : AppRoutes.weatherScreen,
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) =>
            BlocProvider(create: (_) => sl<AuthCubit>(), child: LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.signinScreen,
        name: AppRoutes.signinScreen,
        builder: (context, state) =>
            BlocProvider(create: (_) => sl<AuthCubit>(), child: SignUpScreen()),
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.weatherScreen,
        name: AppRoutes.weatherScreen,
        builder: (context, state) {
          UserEntity userEntity = state.extra as UserEntity;
          // return BlocProvider(
          //   create: (_) => sl<WeatherCubit>()
          //     ..fetchForecastWeather('Cairo')
          //     ..fetchCurrentWeather("Cairo"),
          //   child: WeatherScreen(userEntity: userEntity),
          // );
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<WeatherCubit>()
                  ..fetchForecastWeather('Cairo')
                  ..fetchCurrentWeather("Cairo"),
              ),
              BlocProvider(create: (_) => sl<SuggestionCubit>()),
            ],
            child: WeatherScreen(userEntity: userEntity),
          );
        },
      ),
    ],
  );
}
