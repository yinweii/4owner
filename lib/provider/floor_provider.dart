import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/utils/logger.dart';

class Floor with ChangeNotifier {
  // process
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage ?? '';
  QuerySnapshot? snapshot;
  final devLog = logger;
  //list floor
  List<FloorModel> _floorList = [];
  List<FloorModel> get floorList => _floorList;
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  //firebase
  final _fireStore = FirebaseFirestore.instance;

  Future<void> addNewFloor(FloorModel newFloor) async {
    newFloor =
        FloorModel(id: MinId.getId(), name: newFloor.name, desc: newFloor.desc);
    _floorList.add(newFloor);
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.floorsDb)
          .doc(newFloor.id)
          .set(newFloor.toJson());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> getFloor() async {
    try {
      snapshot = await _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.floorsDb)
          .get();
      List<FloorModel> listExtract = [];
      for (var doccument in snapshot!.docs) {
        listExtract
            .add(FloorModel.fromJson(doccument.data() as Map<String, dynamic>));
      }
      _floorList = listExtract;
    } catch (e) {
      print('FAILD: ${e.toString()}');
    }

    // ignore: unused_element
    FloorModel findById(String id) {
      return _floorList.firstWhere((element) => element.id == id);
    }
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
