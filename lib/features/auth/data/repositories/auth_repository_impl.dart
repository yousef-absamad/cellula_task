import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthUserEntity>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.loginWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Unknown Firebase error'));
    } on GoogleSignInCancelledException {
      return Left(UserCancelledFailure("User cancelled Google Sign-In"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthUserEntity>> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.registerWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Unknown Firebase error'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthUserEntity>> loginWithGoogle() async {
    try {
      final user = await remoteDataSource.loginWithGoogle();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.message ?? 'Unknown Firebase error'));
    } on GoogleSignInCancelledException {
      return Left(UserCancelledFailure("User cancelled Google Sign-In"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<Either<Failure, void>> sendResetPasswordEmail(String email) async {
    try {
      await remoteDataSource.sendResetPasswordEmail(email);
      return const Right(null);
    } catch (e) {
      return left(ResetPasswordFailure("Failed to send reset email"));
    }
  }
}
