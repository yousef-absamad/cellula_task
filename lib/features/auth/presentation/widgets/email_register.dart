import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/handlers/auth_state_handler.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailRegister extends StatelessWidget {
  const EmailRegister({
    super.key,
    required this.nameController,
    required this.authCubit,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final AuthCubit authCubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        final handler = AuthStateHandler(context);
        if (state is EmailRegisterSuccess) {
          await handler.handleEmailRegisterSuccess(state, nameController.text);
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
        if (state is EmailRegisterLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return SizedBox(
          child: CustomButton(
            text: "Create Account",
            color: AppColors.secondary,
            onPressed: () {
              authCubit.registerWithEmail(
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
