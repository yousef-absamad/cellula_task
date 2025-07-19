import '../../domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.uid,
    super.email,
    super.name,
    super.photoUrl,
  });

  factory AuthUserModel.fromFirebaseUser(dynamic user) {
    return AuthUserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
