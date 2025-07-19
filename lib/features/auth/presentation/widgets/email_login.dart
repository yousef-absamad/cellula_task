import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/handlers/auth_state_handler.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({
    super.key,
    required this.authCubit,
    required this.emailController,
    required this.passwordController,
  });

  final AuthCubit authCubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is EmailLoginLoading || current is EmailLoginFailure,
      listener: (context, state) async {
        final handler = AuthStateHandler(context);
        if (state is EmailLoginSuccess) {
          await handler.handleEmailLoginSuccess(state);
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
        if (state is EmailLoginLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
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
    );
  }
}
