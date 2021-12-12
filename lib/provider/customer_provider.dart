import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/utils/logger.dart';

class Customer with ChangeNotifier {
  // process
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage ?? '';
  QuerySnapshot? snapshot;
  final devLog = logger;
  //list
  List<CustomerModel> _listCustomer = [];
  List<CustomerModel> get listCustomer => _listCustomer;

  final userUID = FirebaseAuth.instance.currentUser?.uid;
  //firebase
  final _fireStore = FirebaseFirestore.instance;
  // add new customer
  Future<void> addNewCustomer(CustomerModel customer) async {
    var newCustomer = CustomerModel(
      id: customer.id,
      name: customer.name,
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
      status: customer.status,
    );
    setIsLoading(true);
    _listCustomer.add(newCustomer);

    setIsLoading(false);
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
