import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/api_service/api_service.dart';

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

  //api service
  final _apiService = ApiService();

  final userUID = FirebaseAuth.instance.currentUser?.uid;

  Future<void> getRoomByIdFloor(String? idFloor) async {
    List<RoomModel> listExtract = [];
    _isLoading = isLoading(true);
    snapshot = await _apiService.findData(
        colect: Constants.roomtDb, field: 'idfloor', param: idFloor!);

    _isLoading = isLoading(false);

    for (var docs in snapshot!.docs) {
      listExtract.add(RoomModel.fromMap(docs.data() as Map<String, dynamic>));
    }

    _listRoom = listExtract;

    notifyListeners();
  }

  Future<void> getAllRoom() async {
    List<RoomModel> listExtract = [];
    try {
      _isLoading = isLoading(true);
      snapshot = await _apiService.getData(colect: Constants.roomtDb);

      for (var docs in snapshot!.docs) {
        listExtract.add(RoomModel.fromMap(docs.data() as Map<String, dynamic>));
      }

      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);
      print('ERROR: ${e.toString()}');
    }

    _listRoom = listExtract;

    notifyListeners();
  }

  Future<void> addNewRoom(String idFloor, RoomModel room) async {
    var newRoom = RoomModel(
      id: room.id,
      idfloor: idFloor,
      roomname: room.roomname,
      area: room.area,
      price: room.price,
      note: room.note,
      limidperson: room.limidperson,
      status: Constants.room_status_null,
      floorname: room.floorname,
    );
    _listRoom.add(newRoom);

    try {
      _isLoading = isLoading(true);
      await _apiService.create(
          colect: Constants.roomtDb, dataID: room.id!, data: newRoom.toMap());

      _isLoading = isLoading(false);
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
      if (room.idfloor == idFloor) {
        findByFloor.add(room);
      }
      findByFloor
          .sort((a, b) => (a.roomname ?? '').compareTo(b.roomname ?? ''));
      // findByFloor.sort((a, b) => (int.parse(a.romName!.split('-').last))
      //     .compareTo(int.parse(b.romName!.split('-').last)));
    }

    return findByFloor;
  } //find list by id floor

  List<RoomModel> findRoomEmpty(String? idFloor) {
    List<RoomModel> findByFloor = [];
    for (var room in _listRoom) {
      if (room.idfloor == idFloor &&
          room.status == Constants.room_status_null) {
        findByFloor.add(room);
      }
    }

    return findByFloor;
  }

  List<RoomModel> findAllRoomEmpty() {
    List<RoomModel> findByFloor = [];
    for (var room in _listRoom) {
      if (room.status == Constants.room_status_null) {
        findByFloor.add(room);
      }
    }

    return findByFloor;
  }
}
