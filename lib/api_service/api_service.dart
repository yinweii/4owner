import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:owner_app/constants/constants.dart';

class ApiService {
  //firebase
  final _fireStore = FirebaseFirestore.instance;
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  Future<void> create(
      {required String colect,
      required String dataID,
      required Map<String, dynamic> data}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .set(data);
  }

  Future<QuerySnapshot> getData({required String colect}) async {
    QuerySnapshot snap = await _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .get();
    return snap;
  }

  Future<void> update(
      {required String colect,
      required String dataID,
      required Map<String, dynamic> data}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .update(data);
  }

  Future<void> delete({required String colect, required String dataID}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .delete();
  }
}
