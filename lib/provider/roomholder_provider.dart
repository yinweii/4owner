import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:owner_app/api_service/api_service.dart';

import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/room_holder.dart';

class RoomHolder with ChangeNotifier, Helper {
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;
  //list
  List<RoomHolderModel> _listHolder = [];
  List<RoomHolderModel> get listHolde => _listHolder;
  //firebase
  //
  QuerySnapshot? snapshot;

  final userUID = FirebaseAuth.instance.currentUser?.uid;
  //firebase

  //
  final _apiService = ApiService();
  void addNewHolder(RoomHolderModel holder) async {
    var newHolder = RoomHolderModel(
      id: holder.id,
      customerId: holder.customerId,
      depositCost: holder.depositCost,
      floorNumber: holder.floorNumber,
      idFloor: holder.idFloor,
      idRoom: holder.idRoom,
      payment: holder.payment,
      customerName: holder.customerName,
      roomNumber: holder.roomNumber,
      startTime: holder.startTime,
      status: Constants.holder_waitting,
    );
    _listHolder.add(newHolder);
    try {
      _isLoading = isLoading(true);
      await _apiService.create(
          colect: Constants.holdRoom,
          dataID: holder.id ?? '',
          data: newHolder.toMap());
      //update customer infor
      await _apiService.update(
          colect: Constants.customerDb,
          dataID: holder.customerId,
          data: {
            'floorNumber': holder.floorNumber,
            'idFloor': holder.idFloor,
            'idRoom': holder.idRoom,
            'roomNumber': holder.roomNumber,
          });
      await _apiService.update(
          colect: Constants.roomtDb,
          dataID: holder.idRoom ?? '',
          data: {'status': Constants.room_status_hold});

      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);
      print('ERROR: ${e.toString()}');
    }

    notifyListeners();
  }

  //update status
  Future<void> updateStatus(String id, String? status) async {
    await _apiService.update(colect: Constants.holdRoom, dataID: id, data: {
      'status': status,
    });
  }

  Future<void> getHolder() async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _apiService.getData(colect: Constants.holdRoom);
      if (snapshot != null) {
        List<RoomHolderModel> list = [];
        for (var documnet in snapshot!.docs) {
          list.add(
              RoomHolderModel.fromMap(documnet.data() as Map<String, dynamic>));
        }
        _isLoading = isLoading(false);
        _listHolder = list;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = isLoading(false);
      print('ERROR: ${e.toString()}');
    }
  }

  // get hold by status
  List<RoomHolderModel> getHolderByStatus(
      {required String status, bool isCancel = false}) {
    List<RoomHolderModel> getHolderByStatus = [];
    for (var holder in _listHolder) {
      if (isCancel) {
        if (holder.status == status) {
          getHolderByStatus.add(holder);
        }
      } else {
        var date = DateTime.now().subtract(Duration(days: 1));
        if (holder.status == status && date.isBefore(holder.startTime!)) {
          getHolderByStatus.add(holder);
        }
      }
    }
    return getHolderByStatus;
  } // get hold by status

  List<RoomHolderModel> getHolderOutdate() {
    var date = DateTime.now().subtract(Duration(days: 1, hours: 0));
    List<RoomHolderModel> getHolderOutdate = [];
    for (var holder in _listHolder) {
      if (date.compareTo(holder.startTime!) == 1 &&
          holder.status == Constants.holder_waitting) {
        getHolderOutdate.add(holder);
      }
    }

    return getHolderOutdate;
  }

  RoomHolderModel findHolderById(String id) => _listHolder.firstWhere(
        (element) => element.id == id,
        orElse: null,
      );
}
