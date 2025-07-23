import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/services_locator.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      navigateBasedOnAuth();
    });
  }

  Future<void> navigateBasedOnAuth() async {
    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser != null) {
      final result = await sl<GetUserDataUseCase>().execute(authUser.uid);

      result.fold(
        (failure) {
          GoRouter.of(context).goNamed(AppRoutes.loginScreen);
        },
        (user) {
          GoRouter.of(context).goNamed(AppRoutes.weatherScreen, extra: user);
        },
      );
    } else {
      GoRouter.of(context).goNamed(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      ),
    );
  }
}
