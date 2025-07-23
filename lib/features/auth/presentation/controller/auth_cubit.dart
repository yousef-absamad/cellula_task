import 'package:cellula_task/features/auth/domain/usecases/send_reset_password_email.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_with_email_use_case.dart';
import '../../domain/usecases/register_with_email_use_case.dart';
import '../../domain/usecases/login_with_google_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithEmailUseCase loginWithEmailUseCase;
  final RegisterWithEmailUseCase registerWithEmailUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final SendResetPasswordEmailUseCase sendResetPasswordEmailUseCase;

  AuthCubit({
    required this.loginWithEmailUseCase,
    required this.registerWithEmailUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
    required this.sendResetPasswordEmailUseCase,
  }) : super(AuthInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(EmailLoginLoading());
    final result = await loginWithEmailUseCase.execute(email, password);
    result.fold(
      (failure) => emit(EmailLoginFailure(failure.message)),
      (authUserEntity) => emit(EmailLoginSuccess(authUserEntity)),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    emit(EmailRegisterLoading());
    final result = await registerWithEmailUseCase.execute(email, password);
    result.fold(
      (failure) => emit(EmailRegisterFailure(failure.message)),
      (authUserEntity) => emit(EmailRegisterSuccess(authUserEntity)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());
    final result = await loginWithGoogleUseCase.execute();
    result.fold(
      (failure) => emit(GoogleLoginFailure(failure.message)),
      (authUserEntity) => emit(GoogleLoginSuccess(authUserEntity)),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    await logoutUseCase.execute();
    if (isClosed) return;
    emit(LogoutSuccess());
  }

  Future<void> sendResetPasswordEmail(String email) async {
    emit(ResetPasswordLoading());
    final result = await sendResetPasswordEmailUseCase.execute(email);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
