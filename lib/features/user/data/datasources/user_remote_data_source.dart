import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseUserRemoteDataSource {
  Future<void> saveUserData(UserModel user);
  Future<UserModel?> getUserData(String uid);
}

class UserRemoteDataSource implements BaseUserRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUserData(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  @override
  Future<UserModel?> getUserData(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (!snapshot.exists) return null;
    return UserModel.fromMap(snapshot.data()!);
  }
}
