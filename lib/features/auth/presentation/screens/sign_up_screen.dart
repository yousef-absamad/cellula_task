import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_divider.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:cellula_task/features/auth/presentation/widgets/email_register.dart';
import 'package:cellula_task/features/auth/presentation/widgets/google_auth.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpScreen({super.key});

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
                Text("Welcome", style: AppTextStyles.headerStyle),
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

                EmailRegister(
                  nameController: nameController,
                  authCubit: authCubit,
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                const HeightSpace(50),
                CutomDivider(),
                const HeightSpace(25),
                GoogleAuth(
                  authCubit: authCubit,
                  textButton: "Signin with google",
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyles.primaryStyle,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        GoRouter.of(context).pop();
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
      ),
    );
  }
}