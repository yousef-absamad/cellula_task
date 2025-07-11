import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.email,
    super.name,
    super.photoUrl,
  });

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
