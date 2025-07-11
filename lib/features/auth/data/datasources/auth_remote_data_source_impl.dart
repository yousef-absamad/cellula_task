import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final String webCleantId =
      "887705506624-lth31mrvte67hju9l5tl1epir9q7ej1t.apps.googleusercontent.com";

  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user!;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> registerWithEmail(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user!;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await googleSignIn.initialize(clientId: webCleantId);
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user!;
    return UserModel.fromFirebaseUser(user);

 
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
