import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailUseCase {
  final AuthRepository repository;

  LoginWithEmailUseCase(this.repository);

  Future<Either<Failure, AuthUserEntity>> execute(
    String email,
    String password,
  ) {
    return repository.loginWithEmail(email, password);
  }
}
