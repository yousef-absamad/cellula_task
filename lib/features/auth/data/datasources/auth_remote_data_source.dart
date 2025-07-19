import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> loginWithEmail(String email, String password);
  Future<AuthUserModel> registerWithEmail(String email, String password);
  Future<AuthUserModel> loginWithGoogle();
  Future<void> logout();
  Future<void> sendResetPasswordEmail(String email);
}
