import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/room_model.dart';

class RoomProvider with ChangeNotifier, Helper {
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;
  //list
  List<RoomModel> _listRoom = [];
  List<RoomModel> get listRoom => _listRoom;

  //
  QuerySnapshot? snapshot;

  final userUID = FirebaseAuth.instance.currentUser?.uid;
  //firebase
  final _fireStore = FirebaseFirestore.instance;

  Future<void> getAllRoom() async {
    List<RoomModel> listExtract = [];
    _isLoading = isLoading(true);
    snapshot = await _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(Constants.roomtDb)
        .get();

    for (var docs in snapshot!.docs) {
      listExtract.add(RoomModel.fromMap(docs.data() as Map<String, dynamic>));
    }
    _isLoading = isLoading(false);
    _listRoom = listExtract;
    notifyListeners();
  }

  //find room by id
  RoomModel findRoomById(String id) =>
      _listRoom.firstWhere((element) => element.id == id);
}
