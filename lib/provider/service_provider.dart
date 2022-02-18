// ignore_for_file: null_check_always_fails

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/model/service_model.dart';
import 'package:owner_app/utils/logger.dart';

class ServiceProvider with ChangeNotifier {
  //statc const
  static const freeService = 'Miễn phí';
  static const feeService = 'Trả phí';
  // process
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage ?? '';
  QuerySnapshot? snapshot;
  final devLog = logger;
  //list service free
  List<RoomService> _serviceList = [];
  List<RoomService> get serviceList => _serviceList;
  //list service fee
  List<RoomService> _serviceListFee = [];
  List<RoomService> get serviceListFee => _serviceListFee;
  //list all service fee
  List<RoomService> _serviceAll = [];
  List<RoomService> get serviceAll => _serviceAll;
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  File? _file;
  File? get file => _file;

  //firebase
  final _fireStore = FirebaseFirestore.instance;

  Future<void> addNewServiceFloor(RoomService newService) async {
    newService = RoomService(
        id: MinId.getId(),
        name: newService.name,
        price: newService.price,
        status: newService.status,
        note: newService.note);
    _serviceList.add(newService);
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.serviceDb)
          .doc(newService.id)
          .set(newService.toMap());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateService(String id, RoomService newService) async {
    final serviceIndex = _serviceAll.indexWhere((prod) => prod.id == id);
    newService = RoomService(
        id: id,
        name: newService.name,
        price: newService.price,
        status: newService.status,
        note: newService.note);

    if (serviceIndex >= 0) {
      _serviceAll[serviceIndex] = newService;
      try {
        _fireStore
            .collection(Constants.userDb)
            .doc(userUID)
            .collection(Constants.serviceDb)
            .doc(newService.id)
            .update(newService.toMap());
      } catch (e) {
        print('ERROR:' + e.toString());
      }
      notifyListeners();
    }
  }

  //ghet all service
  Future<void> getAllServiceFree() async {
    try {
      snapshot = await _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.serviceDb)
          .get();
      List<RoomService> listExtract = [];
      for (var doccument in snapshot!.docs) {
        listExtract
            .add(RoomService.fromMap(doccument.data() as Map<String, dynamic>));
      }
      _serviceAll = listExtract;

      notifyListeners();
    } catch (e) {
      print('FAILD: ${e.toString()}');
    }
  }

  Future<void> getRoomServiceFree() async {
    setIsLoading(true);
    try {
      snapshot = await _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.serviceDb)
          .where('status', isEqualTo: freeService)
          .get();
      List<RoomService> listExtract = [];
      for (var doccument in snapshot!.docs) {
        listExtract
            .add(RoomService.fromMap(doccument.data() as Map<String, dynamic>));
      }
      setIsLoading(false);
      _serviceList = listExtract;

      notifyListeners();
    } catch (e) {
      setIsLoading(false);
      print('FAILD: ${e.toString()}');
    }
  }

  Future<void> getRoomServiceFee() async {
    try {
      snapshot = await _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.serviceDb)
          .where('status', isEqualTo: feeService)
          .get();
      List<RoomService> listExtract = [];
      for (var doccument in snapshot!.docs) {
        listExtract
            .add(RoomService.fromMap(doccument.data() as Map<String, dynamic>));
      }
      _serviceListFee = listExtract;

      notifyListeners();
    } catch (e) {
      print('FAILD: ${e.toString()}');
    }
  }

  Future<void> deleteService(String id) async {
    // final serviceIndex = _serviceAll.indexWhere((prod) => prod.id == id);
    // var exitService = _serviceAll[serviceIndex];
    _serviceAll.removeWhere((element) => element.id == id);
    try {
      snapshot = await _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.serviceDb)
          .doc(id)
          .delete()
          .then((value) => null);
    } catch (e) {
      print('FAILD: ${e.toString()}');
    }
    notifyListeners();
  }

//find Service by ID
  RoomService? findById(String? id) {
    return _serviceAll.firstWhere(
      (element) => element.id == id,
      orElse: () => RoomService(id: '', price: 0),
    );
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}
