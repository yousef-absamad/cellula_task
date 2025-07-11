import 'package:cellula_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthState { 
}

class AuthInitial extends AuthState {}

// Sign In with Email
class EmailLoginLoading extends AuthState {}
class EmailLoginSuccess extends AuthState {
  final UserEntity user;
  EmailLoginSuccess(this.user);
}
class EmailLoginFailure extends AuthState {
  final String message;
  EmailLoginFailure(this.message);
}

// Register with Email
class EmailRegisterLoading extends AuthState {}
class EmailRegisterSuccess extends AuthState {
  final UserEntity user;
  EmailRegisterSuccess(this.user);
}
class EmailRegisterFailure extends AuthState {
  final String message;
  EmailRegisterFailure(this.message);
}

// Google Sign-In
class GoogleLoginLoading extends AuthState {}
class GoogleLoginSuccess extends AuthState {
  final UserEntity user;
  GoogleLoginSuccess(this.user);
}
class GoogleLoginFailure extends AuthState {
  final String message;
  GoogleLoginFailure(this.message);
}
