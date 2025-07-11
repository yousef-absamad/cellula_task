
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

  AuthCubit({
    required this.loginWithEmailUseCase,
    required this.registerWithEmailUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(EmailLoginLoading());
    final result = await loginWithEmailUseCase.execute(email, password);
    result.fold(
      (failure) => emit(EmailLoginFailure(failure.message)),
      (user) => emit(EmailLoginSuccess(user)),
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    emit(EmailRegisterLoading());
    final result = await registerWithEmailUseCase.execute(email, password);
    result.fold(
      (failure) => emit(EmailRegisterFailure(failure.message)),
      (user) => emit(EmailRegisterSuccess(user)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());
    final result = await loginWithGoogleUseCase.execute();
    result.fold(
      (failure) => emit(GoogleLoginFailure(failure.message)),
      (user) => emit(GoogleLoginSuccess(user)),
    );
  }

  Future<void> logout() async {
    await logoutUseCase.execute();
    emit(AuthInitial());
  }
}
