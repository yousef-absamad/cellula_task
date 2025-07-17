import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
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

    /// Use Cases
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => SendResetPasswordEmailUseCase(sl()));
    sl.registerLazySingleton(() => RegisterWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
    sl.registerLazySingleton(() => LoginWithEmailUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );

    /// Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );
  }
}
