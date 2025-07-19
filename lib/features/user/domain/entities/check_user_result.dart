import 'package:cellula_task/features/user/domain/entities/user_entity.dart';

class CheckUserResult {
  final UserEntity user;
  final bool isNewUser;

  CheckUserResult({
    required this.user,
    required this.isNewUser,
  });
}