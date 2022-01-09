import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/utils/firebase_path.dart';
import 'package:owner_app/utils/logger.dart';

class Customer with ChangeNotifier, Helper {
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;
  // String? _errorMessage;
  // String get errorMessage => _errorMessage ?? '';
  QuerySnapshot? snapshot;
  final devLog = logger;
  //list
  List<CustomerModel> _listCustomer = [];
  List<CustomerModel> get listCustomer => _listCustomer;

  final userUID = FirebaseAuth.instance.currentUser?.uid;

  // api service
  final _apiService = ApiService();
  // add new customer
  Future<void> addNewCustomer(CustomerModel customer, String idRoom) async {
    var newCustomer = CustomerModel(
      id: customer.id,
      name: customer.name,
      idFloor: customer.idFloor,
      idRoom: customer.idRoom,
      phoneNumber: customer.phoneNumber,
      dateOfBirth: customer.dateOfBirth,
      cardNumber: customer.cardNumber,
      email: customer.email,
      roomNumber: customer.roomNumber,
      floorNumber: customer.floorNumber,
      address: customer.address,
      gender: customer.gender,
      imageFirstUrl: customer.imageFirstUrl,
      imageLastUrl: customer.imageLastUrl,
      status: Constants.no_contract,
      isHolder: true,
    );
    // setIsLoading(true);
    _listCustomer.add(newCustomer);
    try {
      await _apiService.create(
          colect: Constants.customerDb,
          dataID: customer.id ?? '',
          data: newCustomer.toMap());

      if (idRoom.isNotEmpty) {
        _apiService.update(colect: Constants.roomtDb, dataID: idRoom, data: {
          'status': Constants.status_has,
          'listCustomer': FieldValue.arrayUnion(
            [newCustomer.toMap()],
          )
        });

        // _fireStore
        //     .collection(Constants.userDb)
        //     .doc(userUID)
        //     .collection(Constants.roomtDb)
        //     .doc(idRoom)
        //     .update({
        //   'status': Constants.status_has,
        //   'listCustomer': FieldValue.arrayUnion(
        //     [newCustomer.toMap()],
        //   )
        // });
      } else {
        return;
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }

    //setIsLoading(false);
  }

  //upate isHolder
  Future<void> updateHolder(String customerId) async {
    await _apiService
        .update(colect: Constants.customerDb, dataID: customerId, data: {
      'isHolder': false,
    });
  }

  Future<void> getListCustomer() async {
    List<CustomerModel> listExtract = [];
    try {
      _isLoading = isLoading(true);
      snapshot = await _apiService.getData(colect: Constants.customerDb);
      _isLoading = isLoading(false);

      for (var docs in snapshot!.docs) {
        listExtract
            .add(CustomerModel.fromMap(docs.data() as Map<String, dynamic>));
      }
    } catch (e) {
      _isLoading = isLoading(false);
      print('ERROR: ${e.toString()}');
    }

    _listCustomer = listExtract;
    notifyListeners();
  }

  CustomerModel getCustomerByID(String id) =>
      _listCustomer.firstWhere((element) => element.id == id);

  //get list customer have contract
  List<CustomerModel> customerHas() {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if ((customer.idFloor ?? '').isNotEmpty &&
          customer.status != Constants.out_contract) {
        list.add(customer);
      }
    }
    return list;
  }

  //get list customer activity and no contract
  List<CustomerModel> customerNoContract() {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if ((customer.idFloor ?? '').isNotEmpty &&
          customer.status == Constants.no_contract) {
        list.add(customer);
      }
    }
    return list;
  }

  //get list customer have contract

  List<CustomerModel> customerDeposit() {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if ((customer.idFloor ?? '').isEmpty ||
          (customer.idFloor ?? '').isEmpty) {
        list.add(customer);
      }
    }
    return list;
  } //get list customer have contract

  List<CustomerModel> customerOut() {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if (customer.status == Constants.out_contract) {
        list.add(customer);
      }
    }
    return list;
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
