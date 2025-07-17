import 'package:equatable/equatable.dart';
import 'package:cellula_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class EmailLoginLoading extends AuthState {}

class EmailLoginSuccess extends AuthState {
  final UserEntity user;

  const EmailLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class EmailLoginFailure extends AuthState {
  final String message;

  const EmailLoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailRegisterLoading extends AuthState {}

class EmailRegisterSuccess extends AuthState {
  final UserEntity user;

  const EmailRegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class EmailRegisterFailure extends AuthState {
  final String message;

  const EmailRegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GoogleLoginLoading extends AuthState {}

class GoogleLoginSuccess extends AuthState {
  final UserEntity user;

  const GoogleLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class GoogleLoginFailure extends AuthState {
  final String message;

  const GoogleLoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordFailure extends AuthState {
  final String message;

  const ResetPasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
