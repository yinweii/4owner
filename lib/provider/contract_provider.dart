import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:owner_app/api_service/api_service.dart';
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

  final _apiService = ApiService();
  //firebase

  QuerySnapshot? snapshot;
  final devLog = logger;
  Future<void> addContract(ContractModel contract, String idRoom) async {
    var newContract = ContractModel(
      id: contract.id,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      idCustomer: contract.idCustomer,
      dateFrom: contract.dateFrom,
      dateTo: contract.dateTo,
      startPay: contract.startPay,
      numberPerson: contract.numberPerson,
      status: false,
      deposit: contract.deposit,
    );
    _contractList.add(newContract);
    try {
      await _apiService.create(
        colect: Constants.contractDb,
        dataID: contract.id ?? '',
        data: newContract.toMap(),
      );

      await _apiService.update(
        colect: Constants.customerDb,
        dataID: contract.idCustomer ?? '',
        data: {
          'status': Constants.has_contract,
        },
      );
      await _apiService.update(
        colect: Constants.roomtDb,
        dataID: idRoom,
        data: {
          'status': Constants.room_status_has,
        },
      );
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
      snapshot = await _apiService.getData(colect: Constants.contractDb);

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
      idCustomer: contract.idCustomer,
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
        await _apiService.update(
            colect: Constants.contractDb,
            dataID: contract.id ?? '',
            data: newContract.toMap());

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

      await _apiService.delete(colect: Constants.contractDb, dataID: id);

      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);
      devLog.e(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateStatus(String id, String customerId) async {
    try {
      await _apiService.update(
          colect: Constants.contractDb, dataID: id, data: {'status': true});

      await _apiService.update(
        colect: Constants.customerDb,
        dataID: customerId,
        data: {
          'status': Constants.out_contract,
        },
      );
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  List<ContractModel> listContractAc({bool? status, bool isActive = false}) {
    List<ContractModel> listContractAc = [];
    var date = DateTime.now().subtract(Duration(days: 1, hours: 0));

    for (var contract in _contractList) {
      if (isActive) {
        if (contract.status == status && date.isBefore(contract.dateTo!)) {
          listContractAc.add(contract);
        }
      } else {
        if (contract.status == status) {
          listContractAc.add(contract);
        }
      }
    }
    return listContractAc;
  }

  List<ContractModel> listContractOut() {
    List<ContractModel> listContractOut = [];

    var date = DateTime.now().subtract(Duration(days: 1, hours: 0));
    for (var contract in _contractList) {
      if (date.isAfter(contract.dateTo!)) {
        listContractOut.add(contract);
      }
    }

    return listContractOut;
  }

  ContractModel fintContractByID(String id) =>
      _contractList.firstWhere((element) => element.id == id);
}
