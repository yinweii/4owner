import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/contract_model.dart';
import 'package:owner_app/utils/logger.dart';

class Contract with ChangeNotifier, Helper {
  // process
  bool? _isLoading;
  bool get showLoading => _isLoading ?? false;
  // String? _errorMessage;
  // String get errorMessage => _errorMessage ?? '';
  List<ContractModel> _contractList = [];
  List<ContractModel> get contractList => _contractList;
  //firebase
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  //firebase
  final _fireStore = FirebaseFirestore.instance;
  QuerySnapshot? snapshot;
  final devLog = logger;
  Future<void> addContract(ContractModel contract) async {
    var newContract = ContractModel(
      id: contract.id,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      customer: contract.customer,
      dateFrom: contract.dateFrom,
      dateTo: contract.dateTo,
      startPay: contract.startPay,
      numberPerson: contract.numberPerson,
      status: false,
      deposit: contract.deposit,
    );
    _contractList.add(newContract);
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.contractDb)
          .doc(contract.id)
          .set(newContract.toMap());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> onRefresh() async {
    getAllContract();
  }

  Future<void> getAllContract() async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.contractDb)
          .get();
      List<ContractModel> listExtract = [];

      for (var doccument in snapshot!.docs) {
        listExtract.add(
            ContractModel.fromMap(doccument.data() as Map<String, dynamic>));
      }
      _isLoading = isLoading(false);
      _contractList = listExtract;
      notifyListeners();
    } catch (e) {
      isLoading(false);
      print('FAILD: ${e.toString()}');
    }
  }

  Future<void> editContract(String id, ContractModel contract) async {
    final indexEdit = _contractList.indexWhere((element) => element.id == id);
    var newContract = ContractModel(
      id: id,
      createAt: contract.createAt,
      updateAt: DateTime.now(),
      customer: contract.customer,
      dateFrom: contract.dateFrom,
      dateTo: contract.dateTo,
      startPay: contract.startPay,
      numberPerson: contract.numberPerson,
      status: false,
      deposit: contract.deposit,
    );
    if (indexEdit >= 0) {
      _isLoading = isLoading(true);
      _contractList[indexEdit] = newContract;
      try {
        _fireStore
            .collection(Constants.userDb)
            .doc(userUID)
            .collection(Constants.contractDb)
            .doc(contract.id)
            .update(newContract.toMap());
        _isLoading = isLoading(false);
        notifyListeners();
      } catch (e) {
        _isLoading = isLoading(false);
        print('ERROR: ${e.toString()}');
      }
    }
  }

  Future<void> deleteContract(String id) async {
    final existingContractIndex =
        _contractList.indexWhere((prod) => prod.id == id);

    _contractList.removeAt(existingContractIndex);
    notifyListeners();
    try {
      _isLoading = isLoading(true);
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.contractDb)
          .doc(id)
          .delete();
      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);
      devLog.e(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateStatus(String id) async {
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.contractDb)
          .doc(id)
          .update({'status': true});
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  ContractModel fintContractByID(String id) =>
      _contractList.firstWhere((element) => element.id == id);
}
