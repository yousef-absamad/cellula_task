import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/handlers/auth_state_handler.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:cellula_task/features/auth/presentation/widgets/google_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({
    super.key,
    required this.authCubit,
    required this.textButton,
  });

  final AuthCubit authCubit;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GoogleLoginLoading || current is GoogleLoginFailure,
      listener: (context, state) async {
        final handler = AuthStateHandler(context);
        if (state is GoogleLoginSuccess) {
          await handler.handleGoogleLoginSuccess(state);
        }
          if (state is GoogleLoginFailure) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        if (state is GoogleLoginLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return GoogleButton(
          text: textButton,
          onPressed: () {
            authCubit.loginWithGoogle();
          },
        );
      },
    );
  }
}
