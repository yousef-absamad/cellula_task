import 'dart:developer';

import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/core/widgets/custom_button.dart';
import 'package:cellula_task/core/widgets/custom_snackbar.dart';
import 'package:cellula_task/core/widgets/custom_text_field.dart';
import 'package:cellula_task/core/widgets/google_button.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SigninScreen({super.key});

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
              Text("Welcome", style: AppTextStyles.welcomeText),
              const HeightSpace(32),

              CustomTextField(
                hintText: "Name",
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
              ),
              const HeightSpace(16),
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

              const HeightSpace(25),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is EmailRegisterLoading) {
                    const Center(child: CircularProgressIndicator());
                  }
                  if (state is EmailRegisterSuccess) {
                    CustomSnackBar.show(
                      context: context,
                      message: 'Signin successful!',
                    );
                    GoRouter.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.homeScreen);
                  }
                  if (state is EmailRegisterFailure) {
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
                      text: "Create Account",
                      color: AppColors.primary,
                      onPressed: () {
                        authCubit.registerWithEmail(
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
                    text: "Signin with google",
                    onPressed: () {
                      authCubit.loginWithGoogle();
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextStyles.forgotPassword,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
