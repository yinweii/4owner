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
  List<RoomModel>? get listRoom => _listRoom;

  //list by idfloor
  List<RoomModel> _listRoomFloor = [];
  List<RoomModel>? get listRoomFloor => _listRoomFloor;

  //
  QuerySnapshot? snapshot;

  final userUID = FirebaseAuth.instance.currentUser?.uid;
  //firebase
  final _fireStore = FirebaseFirestore.instance;

  Future<void> getRoom(String? idFloor) async {
    List<RoomModel> listExtract = [];
    _isLoading = isLoading(true);
    snapshot = await _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(Constants.roomtDb)
        .where('idFloor', isEqualTo: idFloor)
        .get();
    _isLoading = isLoading(false);

    for (var docs in snapshot!.docs) {
      listExtract.add(RoomModel.fromMap(docs.data() as Map<String, dynamic>));
    }

    _listRoom = listExtract;
    notifyListeners();
  }

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

  void addNewRoom(String idFloor, RoomModel room) {
    var newRoom = RoomModel(
      id: room.id,
      idFloor: idFloor,
      romName: room.romName,
      area: room.area,
      price: room.price,
      note: room.note,
      imageUrl: '',
      status: Constants.status_null,
      listCustomer: [],
    );
    //_listRoom.add(newRoom.toMap());

    try {
      //save to other db
      _isLoading = isLoading(true);
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.roomtDb)
          .doc(room.id)
          .set(newRoom.toMap());
      _isLoading = isLoading(false);
      // update in floor
      // _fireStore
      //     .collection(Constants.userDb)
      //     .doc(userUID)
      //     .collection(Constants.floorsDb)
      //     .doc(idFloor)
      //     .update({
      //   'roomList': FieldValue.arrayUnion([newRoom.toMap()]),
      // });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //find room by id
  RoomModel findRoomById(String id) =>
      _listRoom.firstWhere((element) => element.id == id);

  //find list by id floor
  List<RoomModel> findListRoom(String? idFloor) {
    List<RoomModel> findByFloor = [];
    for (var room in _listRoom) {
      if (room.idFloor == idFloor) {
        findByFloor.add(room);
      }
    }

    return findByFloor;
  } //find list by id floor

  List<RoomModel> findRoomEmpty(String? idFloor) {
    List<RoomModel> findByFloor = [];
    for (var room in _listRoom) {
      if (room.idFloor == idFloor && room.status == Constants.status_null) {
        findByFloor.add(room);
      }
    }

    return findByFloor;
  }
}
