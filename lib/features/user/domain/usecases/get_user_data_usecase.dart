import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/base_user_repository.dart';

class GetUserDataUseCase {
  final BaseUserRepository repository;

  GetUserDataUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String uid) {
    return repository.getUserData(uid);
  }
}
