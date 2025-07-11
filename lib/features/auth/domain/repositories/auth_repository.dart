import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithEmail(String email, String password);
  Future<Either<Failure, UserEntity>> registerWithEmail(String email, String password);
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<void> logout();
}
