import 'package:cellula_task/features/user/data/datasources/user_remote_data_source.dart';
import 'package:cellula_task/features/user/domain/entities/check_user_result.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/base_user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements BaseUserRepository {
  final BaseUserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> saveUserData(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await remoteDataSource.saveUserData(userModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(String uid) async {
    try {
      final userModel = await remoteDataSource.getUserData(uid);
      return Right(userModel!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckUserResult>> checkAndSaveGoogleUser(
    UserEntity user,
  ) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final existingUser = await remoteDataSource.getUserData(user.uid);

      if (existingUser != null) {
        //return Right(existingUser);
        return Right(CheckUserResult(user: existingUser, isNewUser: false));
      } else {
        await remoteDataSource.saveUserData(userModel);
        //return Right(userModel);
        return Right(CheckUserResult(user: userModel, isNewUser: true));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
