class AuthUserEntity {
  final String uid;
  final String? email;
  final String? name;
  final String? photoUrl;

  const AuthUserEntity({
    required this.uid,
    this.email,
    this.name,
    this.photoUrl,
  });
}
