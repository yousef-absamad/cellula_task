import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_divider.dart';
import 'package:cellula_task/features/auth/presentation/widgets/email_login.dart';
import 'package:cellula_task/features/auth/presentation/widgets/google_auth.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/widgets/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

                ResetPassword(
                  emailController: emailController,
                  authCubit: authCubit,
                ),
                const HeightSpace(16),

                EmailLogin(
                  authCubit: authCubit,
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                const HeightSpace(50),
                CutomDivider(),
                const HeightSpace(25),
                GoogleAuth(
                  authCubit: authCubit,
                  textButton: "Login with google",
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