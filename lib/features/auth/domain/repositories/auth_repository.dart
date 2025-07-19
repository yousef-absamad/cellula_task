import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserEntity>> loginWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, AuthUserEntity>> registerWithEmail(
    String email,
    String password,
  );
  
  Future<Either<Failure, AuthUserEntity>> loginWithGoogle();
  
  Future<void> logout();
  
  Future<Either<Failure, void>> sendResetPasswordEmail(String email);
  
  // Future<Either<Failure, AuthUserEntity>> checkAndSaveGoogleUser(
  //   AuthUserEntity user,
  // );
}
