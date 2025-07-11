import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:cellula_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_email_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/logout_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/register_with_email_use_case.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/screens/home_screen.dart';
import 'package:cellula_task/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerationConfig {
  static final AuthRemoteDataSourceImpl _remoteDataSource =
      AuthRemoteDataSourceImpl();

  static final AuthRepositoryImpl _authRepository = AuthRepositoryImpl(
    remoteDataSource: _remoteDataSource,
  );

  static final LoginWithEmailUseCase _loginWithEmailUseCase =
      LoginWithEmailUseCase(_authRepository);
  static final LoginWithGoogleUseCase _loginWithGoogleUseCase =
      LoginWithGoogleUseCase(_authRepository);

  static final RegisterWithEmailUseCase _registerWithEmailUseCase =
      RegisterWithEmailUseCase(_authRepository);
  static final LogoutUseCase _logoutUseCase = LogoutUseCase(_authRepository);

  static GoRouter goRoute = GoRouter(
    initialLocation: AppRoutes.loginScreen,

    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthCubit(
            loginWithEmailUseCase: _loginWithEmailUseCase,
            loginWithGoogleUseCase: _loginWithGoogleUseCase,
            registerWithEmailUseCase: _registerWithEmailUseCase,
            logoutUseCase: _logoutUseCase,
          ),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
