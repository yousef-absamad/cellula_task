
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/core/utils/app_string.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:cellula_task/features/auth/presentation/widgets/show_reset_email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    super.key,
    required this.emailController,
    required this.authCubit,
  });

  final TextEditingController emailController;
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 180.w,
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
    );
  }
}
