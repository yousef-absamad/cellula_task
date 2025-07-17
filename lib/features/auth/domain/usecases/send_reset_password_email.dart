import 'package:cellula_task/core/error/failure.dart';
import 'package:cellula_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SendResetPasswordEmailUseCase {
  final AuthRepository repository;

  SendResetPasswordEmailUseCase(this.repository);

  Future<Either<Failure, void>> execute(String email) {
    return repository.sendResetPasswordEmail(email);
  }
}
