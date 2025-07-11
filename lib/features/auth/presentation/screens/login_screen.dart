import 'dart:developer';

import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/core/widgets/custom_button.dart';
import 'package:cellula_task/core/widgets/custom_snackbar.dart';
import 'package:cellula_task/core/widgets/google_button.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.welcomeBack, style: AppTextStyles.welcomeText),
              const HeightSpace(32),

              CustomTextField(
                hintText: AppStrings.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const HeightSpace(16),

              CustomTextField(
                hintText: AppStrings.password,
                controller: passwordController,
                isPassword: true,
              ),
              const HeightSpace(8),

              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 200.w,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          //TODO
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppTextStyles.forgotPassword,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const HeightSpace(16),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is EmailLoginLoading) {
                    CircularNotchedRectangle();
                  }
                  if (state is EmailLoginSuccess) {
                    CustomSnackBar.show(
                      context: context,
                      message: 'Login successful!',
                    );
                    GoRouter.of(context).pushNamed(AppRoutes.homeScreen);
                  }
                  if (state is EmailLoginFailure) {
                    CustomSnackBar.show(
                      context: context,
                      message: state.message,
                      isError: true,
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    child: CustomButton(
                      text: AppStrings.login,
                      color: AppColors.primary,
                      onPressed: () {
                        authCubit.loginWithEmail(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                    ),
                  );
                },
              ),

              const HeightSpace(50),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.white, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('OR', style: AppTextStyles.forgotPassword),
                  ),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                ],
              ),
              const HeightSpace(25),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is GoogleLoginSuccess) {
                    CustomSnackBar.show(
                      context: context,
                      message: 'Logged in with Google!',
                    );
                    GoRouter.of(context).pushNamed(AppRoutes.homeScreen);
                  }

                  if (state is GoogleLoginFailure) {
                    CustomSnackBar.show(
                      context: context,
                      message: state.message,
                      isError: true,
                    );
                    log(state.message);
                  }
                },
                builder: (context, state) {
                  return GoogleButton(
                    text: "Login with google",
                    onPressed: () {
                      authCubit.loginWithGoogle();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
