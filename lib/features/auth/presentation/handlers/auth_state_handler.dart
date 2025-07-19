import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/services_locator.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:cellula_task/features/user/data/models/user_model.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:cellula_task/features/user/domain/usecases/check_and_save_google_user_usecase.dart';
import 'package:cellula_task/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:cellula_task/features/user/domain/usecases/save_user_data_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AuthStateHandler {
  final BuildContext context;

  AuthStateHandler(this.context);

  Future<void> handleEmailLoginSuccess(EmailLoginSuccess state) async {
    final userResult = await sl<GetUserDataUseCase>().execute(state.authUserEntity.uid);

    userResult.fold(
      (failure) => _showError(failure.message),
      (userEntity) {
        _showSuccess("Login successful!");
        _navigate(userEntity);
      },
    );
  }

  Future<void> handleEmailRegisterSuccess(EmailRegisterSuccess state, String name) async {
    final user = UserModel(
      uid: state.authUserEntity.uid,
      name: name,
      email: state.authUserEntity.email ?? '',
      profileImage: '',
    );

    final saveResult = await sl<SaveUserDataUseCase>().execute(user);

    saveResult.fold(
      (failure) => _showError(failure.message),
      (_) {
        _showSuccess("Sign up successful!");
        _navigate(user);
      },
    );
  }

  Future<void> handleGoogleLoginSuccess(GoogleLoginSuccess state) async {
    final user = UserModel(
      uid: state.authUserEntity.uid,
      name: state.authUserEntity.name ?? '',
      email: state.authUserEntity.email ?? '',
      profileImage: state.authUserEntity.photoUrl ?? '',
    );

    final result = await sl<CheckAndSaveGoogleUserUsecase>().execute(user);

    result.fold(
      (failure) => _showError(failure.message),
      (userEntity) {
        _showSuccess("Logged in with Google!");
        _navigate(userEntity);
      },
    );
  }

  void _showSuccess(String message) {
    CustomSnackBar.show(context: context, message: message);
  }

  void _showError(String message) {
    CustomSnackBar.show(context: context, message: "Firestore: $message", isError: true);
  }

  void _navigate(UserEntity user) {
    GoRouter.of(context).goNamed(AppRoutes.weatherScreen, extra: user);
  }
}
