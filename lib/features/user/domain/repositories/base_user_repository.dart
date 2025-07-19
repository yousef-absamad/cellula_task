import 'package:cellula_task/features/user/domain/entities/check_user_result.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class BaseUserRepository {
  Future<Either<Failure, void>> saveUserData(UserEntity user);
  Future<Either<Failure, UserEntity>> getUserData(String uid);
  Future<Either<Failure, CheckUserResult>> checkAndSaveGoogleUser(UserEntity user);
}
