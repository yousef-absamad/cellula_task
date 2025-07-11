import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String email, String password);
  Future<UserModel> loginWithGoogle();
  Future<void> logout();
}


