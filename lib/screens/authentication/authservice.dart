import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';

import 'package:owner_app/model/user_model.dart';

class AuthService with Helper {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(uid: user.uid, email: user.email);
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map((_userFromFirebase));
  }

  Future<UserModel?>? signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(credential.user);
    } catch (e) {
      _errorMessage = erroMessage(e.toString());
    }
  }

  Future<UserModel?>? register(
      String username, String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    _fireStore.collection(Constants.userDb).doc(credential.user?.uid).set({
      'uid': credential.user?.uid,
      'email': email,
      'name': username,
      'avatarUrl': '',
    });

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
