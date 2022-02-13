import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/customer_model.dart';

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
      idfloor: customer.idfloor,
      idroom: customer.idroom,
      phonenumber: customer.phonenumber,
      dateOfBirth: customer.dateOfBirth,
      cardnumber: customer.cardnumber,
      email: customer.email,
      roomnumber: customer.roomnumber,
      floornumber: customer.floornumber,
      address: customer.address,
      gender: customer.gender,
      imagefirsturl: customer.imagefirsturl,
      imagelasturl: customer.imagelasturl,
      status: Constants.no_contract,
      isholder: true,
    );
    // setIsLoading(true);
    _listCustomer.add(newCustomer);
    try {
      await _apiService.create(
          colect: Constants.customerDb,
          dataID: customer.id ?? '',
          data: newCustomer.toMap());

      await _apiService.update(
          colect: Constants.roomtDb,
          dataID: idRoom,
          data: ({'status': Constants.room_status_has}));
    } on Exception catch (e) {
      // TODO
      print(
        e.toString(),
      );
    }

    //setIsLoading(false);
  }

  Future<void> updateCustomer(
      CustomerModel customer, String idCustomer, String idRoom) async {
    final indexEdit =
        _listCustomer.indexWhere((element) => element.id == idCustomer);
    var newCustomerEdt = CustomerModel(
      name: customer.name,
      idfloor: customer.idfloor,
      idroom: customer.idroom,
      phonenumber: customer.phonenumber,
      dateOfBirth: customer.dateOfBirth,
      cardnumber: customer.cardnumber,
      email: customer.email,
      roomnumber: customer.roomnumber,
      floornumber: customer.floornumber,
      address: customer.address,
      gender: customer.gender,
      imagefirsturl: customer.imagefirsturl,
      imagelasturl: customer.imagelasturl,
      status: Constants.no_contract,
      isholder: true,
    );

    if (indexEdit > 0) {
      _listCustomer[indexEdit] = newCustomerEdt;

      try {
        await _apiService.update(
            colect: Constants.customerDb,
            dataID: idCustomer,
            data: newCustomerEdt.toMap());
      } catch (e) {
        print(e.toString());
      }
    }
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

  Future<void> onRefesh() async {
    getListCustomer();
  }

  CustomerModel getCustomerByID(String id) =>
      _listCustomer.firstWhere((element) => element.id == id);

  //get list customer have contract
  List<CustomerModel> customerHas() {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if ((customer.idfloor ?? '').isNotEmpty &&
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
      if ((customer.idfloor ?? '').isNotEmpty &&
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
      if ((customer.idfloor ?? '').isEmpty ||
          (customer.idfloor ?? '').isEmpty) {
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

  // find customer by room
  List<CustomerModel> customerByRoom(String idRoom) {
    List<CustomerModel> list = [];
    for (var customer in _listCustomer) {
      if (customer.idroom == idRoom) {
        list.add(customer);
      }
    }
    return list;
  }

  Future<void> deleteCustomer(String idCustomer) async {
    final existingCustomer =
        _listCustomer.indexWhere((prod) => prod.id == idCustomer);

    _listCustomer.remove(existingCustomer);
    notifyListeners();
    try {
      await _apiService.delete(
          colect: Constants.customerDb, dataID: idCustomer);
      notifyListeners();
    } catch (e) {}
  }
}
