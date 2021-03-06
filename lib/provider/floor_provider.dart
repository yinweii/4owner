import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:provider/provider.dart';
import 'package:owner_app/utils/logger.dart';

class Floor with ChangeNotifier, Helper {
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;
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

  //
  final _apiService = ApiService();

  // add new floor
  Future<void> addNewFloor(FloorModel newFloor) async {
    isLoading(true);
    newFloor = FloorModel(
      id: newFloor.id,
      name: newFloor.name,
      desc: newFloor.desc,
    );
    _floorList.add(newFloor);
    try {
      await _apiService.create(
          colect: Constants.floorsDb,
          dataID: newFloor.id ?? '',
          data: newFloor.toMap());

      // _fireStore
      //     .collection(Constants.userDb)
      //     .doc(userUID)
      //     .collection(Constants.floorsDb)
      //     .doc(newFloor.id)
      //     .set(newFloor.toMap());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //add a new room in flooor

  Future<void> getFloor() async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _apiService.getData(colect: Constants.floorsDb);

      //  = await _fireStore
      //     .collection(Constants.userDb) //
      //     .doc(userUID)
      //     .collection(Constants.floorsDb)
      //     .get();
      _isLoading = isLoading(false);

      List<FloorModel> listExtract = [];

      for (var doccument in snapshot!.docs) {
        listExtract
            .add(FloorModel.fromMap(doccument.data() as Map<String, dynamic>));
      }
      listExtract.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));

      _floorList = listExtract;
    } catch (e) {
      print('FAILD: ${e.toString()}');
    }
  }

// get floor infor detail
  Future<FloorModel?> getFloorDetail(String idFloor) async {
    try {
      _isLoading = isLoading(true);
      documentSnapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.floorsDb)
          .doc(idFloor)
          .get();

      _floorModel =
          FloorModel.fromMap(documentSnapshot?.data() as Map<String, dynamic>);

      _isLoading = isLoading(false);
      notifyListeners();
    } on Exception catch (e) {
      // TODO
      print('ERROR: ${e.toString()}');
    }
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
