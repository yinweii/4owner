import 'package:firebase_auth/firebase_auth.dart';

import 'package:owner_app/model/user_model.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
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
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
