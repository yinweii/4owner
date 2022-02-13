import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/user_model.dart';

class Profile with ChangeNotifier, Helper {
  //firebase
  final _fireStore = FirebaseFirestore.instance;
  final userUID = FirebaseAuth.instance.currentUser?.uid;
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<void> getUserModel() async {
    try {
      _isLoading = isLoading(true);
      DocumentSnapshot<Map<String, dynamic>> dataUser =
          await _fireStore.collection(Constants.userDb).doc(userUID).get();
      _userModel = UserModel.fromMap(dataUser.data() as Map<String, dynamic>);

      _isLoading = isLoading(false);
      notifyListeners();
      print(_userModel.toString());
    } catch (e) {}
  }
}
