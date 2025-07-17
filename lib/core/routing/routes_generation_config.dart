import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/services_locator.dart';
import 'package:cellula_task/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:cellula_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_email_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/logout_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/register_with_email_use_case.dart';
import 'package:cellula_task/features/auth/domain/usecases/send_reset_password_email.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/screens/home_screen.dart';
import 'package:cellula_task/features/auth/presentation/screens/login_screen.dart';
import 'package:cellula_task/features/auth/presentation/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerationConfig {
  static GoRouter goRoute = GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser == null
        ? AppRoutes.loginScreen
        : AppRoutes.homeScreen,

    routes: [
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signinScreen,
        name: AppRoutes.signinScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: SigninScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => BlocProvider.value(
          value: sl<AuthCubit>(),
          child: HomeScreen(),
        ),
      ),
    ],
  );
}
