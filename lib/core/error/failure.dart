abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);
}

class UserCancelledFailure extends Failure {
  UserCancelledFailure(super.message);
}

class ResetPasswordFailure extends Failure {
  ResetPasswordFailure(super.message);
}

class GoogleSignInCancelledException implements Exception {}
