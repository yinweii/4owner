import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:provider/provider.dart';
import 'package:owner_app/utils/logger.dart';

class Floor with ChangeNotifier, Helper {
  // process
  // bool _isLoading = false;
  // String? _errorMessage;
  // bool get isLoading => _isLoading;
  // String get errorMessage => _errorMessage ?? '';
  QuerySnapshot? snapshot;
  DocumentSnapshot? documentSnapshot;
  final devLog = logger;
  //list floor
  List<FloorModel> _floorList = [];
  List<FloorModel> get floorList => _floorList;

  //
  FloorModel _floorModel = FloorModel();
  FloorModel get floorModel => _floorModel;

  //list
  List<RoomModel> _listRoom = [];
  List<RoomModel> get listRoom => _listRoom;

  //firebase
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  //firebase
  final _fireStore = FirebaseFirestore.instance;

  // add new floor
  Future<void> addNewFloor(FloorModel newFloor) async {
    newFloor = FloorModel(
      id: newFloor.id,
      name: newFloor.name,
      desc: newFloor.desc,
    );
    _floorList.add(newFloor);
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.floorsDb)
          .doc(newFloor.id)
          .set(newFloor.toMap());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //add a new room in flooor
  void addNewRoom(String idFloor, RoomModel room) {
    var newRoom = RoomModel(
      id: room.id,
      romName: room.romName,
      area: room.area,
      price: room.price,
      person: room.person,
      note: room.note,
      imageUrl: '',
    );
    //_listRoom.add(newRoom.toMap());

    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.floorsDb)
          .doc(idFloor)
          .update({
        'roomList': FieldValue.arrayUnion([newRoom.toMap()]),
      });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getFloor() async {
    isLoading(true);
    documentSnapshot =
        await _fireStore.collection(Constants.userDb).doc(userUID).get();

    try {
      snapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.floorsDb)
          .get();
      List<FloorModel> listExtract = [];

      for (var doccument in snapshot!.docs) {
        listExtract
            .add(FloorModel.fromMap(doccument.data() as Map<String, dynamic>));
      }
      _floorList = listExtract;

      //print('LIST: ${_floorList.toString()}');
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print('FAILD: ${e.toString()}');
    }
  }

// get floor infor detail
  Future<void> getFloorDetail(String? idFloor) async {
    documentSnapshot = await _fireStore
        .collection(Constants.userDb) //
        .doc(userUID)
        .collection(Constants.floorsDb)
        .doc(idFloor)
        .get();
    // print(
    //     'DETAIL: ${FloorModel.fromMap(documentSnapshot!.data() as Map<String, dynamic>)}');
    _floorModel =
        FloorModel.fromMap(documentSnapshot!.data() as Map<String, dynamic>);
  }

  // ignore: unused_element
  FloorModel findById(String id) {
    return _floorList.firstWhere((element) => element.id == id);
  }

  // void setIsLoading(value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // void setMessage(message) {
  //   _errorMessage = message;
  //   notifyListeners();
  // }
}
