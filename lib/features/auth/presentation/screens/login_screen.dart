import 'dart:developer';

import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:cellula_task/features/auth/presentation/widgets/google_button.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/widgets/show_reset_email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                Text(AppStrings.welcomeBack, style: AppTextStyles.headerStyle),
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
                      buildWhen: (previous, current) =>
                          current is ResetPasswordSuccess ||
                          current is ResetPasswordLoading ||
                          current is ResetPasswordFailure,

                      listener: (context, state) {
                        if (state is ResetPasswordSuccess) {
                          showResetEmailDialog(
                            context,
                            emailController.text.trim(),
                          );
                        }
                        if (state is ResetPasswordFailure) {
                          CustomSnackBar.show(
                            context: context,
                            message: state.message,
                            isError: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        log("ResetPassword");
                        if (state is ResetPasswordLoading) {
                          return Stack(
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ],
                          );
                        }
                        return TextButton(
                          onPressed: () {
                            authCubit.sendResetPasswordEmail(
                              emailController.text,
                            );
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppTextStyles.primaryStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const HeightSpace(16),

                BlocConsumer<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                      current is EmailLoginLoading ||
                      current is EmailLoginFailure,
                  listener: (context, state) {
                    if (state is EmailLoginSuccess) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Login successful!',
                      );
                      GoRouter.of(context).goNamed(AppRoutes.homeScreen);
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
                    log("Email");
                    if (state is EmailLoginLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return SizedBox(
                      child: CustomButton(
                        text: AppStrings.login,
                        color: AppColors.secondary,
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
                      child: Divider(color: AppColors.primary, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('OR', style: AppTextStyles.primaryStyle),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                const HeightSpace(25),
                BlocConsumer<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                      current is GoogleLoginLoading ||
                      current is GoogleLoginFailure,
                  listener: (context, state) {
                    if (state is GoogleLoginSuccess) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Logged in with Google!',
                      );
                      GoRouter.of(context).goNamed(AppRoutes.homeScreen);
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
                    log("google");
                    return GoogleButton(
                      text: "Login with google",
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
                      "Don't have an account?",
                      style: AppTextStyles.primaryStyle,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        GoRouter.of(context).pushNamed(AppRoutes.signinScreen);
                      },
                      child: const Text(
                        "Sign Up",
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
      ),
    );
  }
}
