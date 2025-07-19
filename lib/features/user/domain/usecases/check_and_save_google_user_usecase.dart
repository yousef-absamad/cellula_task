import 'package:cellula_task/features/user/domain/entities/check_user_result.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/base_user_repository.dart';

class CheckAndSaveGoogleUserUsecase {
  final BaseUserRepository repository;

  CheckAndSaveGoogleUserUsecase(this.repository);

  Future<Either<Failure, CheckUserResult>> execute(UserEntity userEntity) {
    return repository.checkAndSaveGoogleUser(userEntity);
  }
}
