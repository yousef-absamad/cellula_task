import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/base_user_repository.dart';

class SaveUserDataUseCase{
  final BaseUserRepository repository;

  SaveUserDataUseCase(this.repository);

  Future<Either<Failure, void>> execute(UserEntity user) {
    
    return repository.saveUserData(user);
  }
}
