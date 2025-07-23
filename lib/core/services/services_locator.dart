import 'package:cellula_task/features/ai_suggestion/data/datasource/ai_service.dart';
import 'package:cellula_task/features/ai_suggestion/data/repositories/weather_suggestion_repository_impl.dart';
import 'package:cellula_task/features/ai_suggestion/domain/repositories/weather_suggestion_repository.dart';
import 'package:cellula_task/features/ai_suggestion/domain/usecase/get_weather_suggestion_use_case.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/user/data/datasources/user_remote_data_source.dart';
import 'package:cellula_task/features/user/data/repositories/user_repository_impl.dart';
import 'package:cellula_task/features/user/domain/repositories/base_user_repository.dart';
import 'package:cellula_task/features/user/domain/usecases/check_and_save_google_user_usecase.dart';
import 'package:cellula_task/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:cellula_task/features/user/domain/usecases/save_user_data_usecase.dart';
import 'package:cellula_task/features/weather/data/Repository/weather_repository_impl.dart';
import 'package:cellula_task/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:cellula_task/features/weather/domain/Repository/weather_repository.dart';
import 'package:cellula_task/features/weather/domain/usecase/get_current_weather_use_case.dart';
import 'package:cellula_task/features/weather/domain/usecase/get_forecast_weather_use_case.dart';
import 'package:cellula_task/features/weather/presentation/Controller/weather_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cellula_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:cellula_task/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:cellula_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cellula_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_email_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/logout_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/register_with_email_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/send_reset_password_email.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Cubits
    sl.registerFactory(
      () => AuthCubit(
        loginWithEmailUseCase: sl(),
        loginWithGoogleUseCase: sl(),
        registerWithEmailUseCase: sl(),
        logoutUseCase: sl(),
        sendResetPasswordEmailUseCase: sl(),
      ),
    );

    sl.registerFactory(() => WeatherCubit(sl(), sl()));

    sl.registerFactory(() => SuggestionCubit(sl()));

    /// Use Cases
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => SendResetPasswordEmailUseCase(sl()));
    sl.registerLazySingleton(() => RegisterWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
    sl.registerLazySingleton(() => LoginWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));
    sl.registerLazySingleton(() => GetForecastWeatherUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => SaveUserDataUseCase(sl()));
    sl.registerLazySingleton(() => CheckAndSaveGoogleUserUsecase(sl()));
    sl.registerLazySingleton(() => GetWeatherSuggestionUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );

    sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<BaseUserRepository>(
      () => UserRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<WeatherSuggestionRepository>(
      () => WeatherSuggestionRepositoryImpl(sl()),
    );

    /// Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<BaseUserRemoteDataSource>(
      () => UserRemoteDataSource(),
    );
    sl.registerLazySingleton<BaseAiDataSource>(() => AiDataSource());
  }
}
