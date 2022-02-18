import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/invoice_model.dart';
import 'package:owner_app/utils/logger.dart';

class Invoice with ChangeNotifier, Helper {
  // process
  bool? _isLoading;
  bool get showLoading => _isLoading ?? false;
  // String? _errorMessage;
  // String get errorMessage => _errorMessage ?? '';
  List<InvoiceModel> _invoiceList = [];
  List<InvoiceModel> get invoiceList => _invoiceList;

  //
  InvoiceModel? invoiceModel;
  //firebase
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  //firebase
  final _fireStore = FirebaseFirestore.instance;
  QuerySnapshot? snapshot;
  final devLog = logger;

  final _apiService = ApiService();

  Future<void> addInvoice(InvoiceModel invoice) async {
    var newInvoice = InvoiceModel(
      id: invoice.id,
      idCustomer: invoice.idCustomer,
      idRoom: invoice.idRoom,
      roomName: invoice.roomName,
      name: invoice.name,
      invoiceDate: invoice.invoiceDate,
      dateFrom: invoice.dateFrom,
      dateTo: invoice.dateTo,
      roomCost: invoice.roomCost,
      electUse: invoice.electUse,
      priceEclect: invoice.priceEclect,
      waterUse: invoice.waterUse,
      waterCost: invoice.waterCost,
      moreService: invoice.moreService,
      priceMoreService: invoice.priceMoreService,
      total: invoice.total,
      punishPrice: invoice.punishPrice,
      totalAmount: invoice.totalAmount,
      discount: invoice.discount,
      isPayment: invoice.isPayment,
    );
    _invoiceList.add(newInvoice);

    try {
      await _apiService.create(
          colect: Constants.invoiceDb,
          dataID: invoice.id ?? '',
          data: newInvoice.toMap());
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  //get all invoice
  Future<void> getAllInvoice({bool isPay = false}) async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.invoiceDb)
          .where('isPayment', isEqualTo: isPay)
          .get();

      List<InvoiceModel> listExtract = [];

      for (var doccument in snapshot!.docs) {
        listExtract.add(
            InvoiceModel.fromMap(doccument.data() as Map<String, dynamic>));
      }
      _isLoading = isLoading(false);
      _invoiceList = listExtract;
      notifyListeners();
      //! log data
      devLog.i(_invoiceList[0]);
      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);

      print('FAILD: ${e.toString()}');
    }
  } //get all invoice

  Future<void> getAllInvoiceOutDate({bool isPay = false}) async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.invoiceDb)
          .where('dateTo', isLessThanOrEqualTo: DateTime.now())
          .get();

      List<InvoiceModel> listExtract = [];

      for (var doccument in snapshot!.docs) {
        listExtract.add(
            InvoiceModel.fromMap(doccument.data() as Map<String, dynamic>));
      }
      print('DATA: ${snapshot!.docs}');
      _isLoading = isLoading(false);
      _invoiceList = listExtract;
      notifyListeners();
      //! log data
      devLog.i(_invoiceList[0]);
      _isLoading = isLoading(false);
    } catch (e) {
      _isLoading = isLoading(false);

      print('FAILD: ${e.toString()}');
    }
  } //get all invoice

  Future<void> updateInvoice(String id, InvoiceModel invoice) async {
    final indexEdit = _invoiceList.indexWhere((element) => element.id == id);
    var newInvoice = InvoiceModel(
      id: id,
      idCustomer: invoice.idCustomer,
      idRoom: invoice.idRoom,
      roomName: invoice.roomName,
      name: invoice.name,
      invoiceDate: invoice.invoiceDate,
      dateFrom: invoice.dateFrom,
      dateTo: invoice.dateTo,
      roomCost: invoice.roomCost,
      electUse: invoice.electUse,
      priceEclect: invoice.priceEclect,
      waterUse: invoice.waterUse,
      waterCost: invoice.waterCost,
      moreService: invoice.moreService,
      priceMoreService: invoice.priceMoreService,
      total: invoice.total,
      punishPrice: invoice.punishPrice,
      totalAmount: invoice.totalAmount,
      discount: invoice.discount,
      isPayment: invoice.isPayment,
    );
    if (indexEdit >= 0) {
      _isLoading = isLoading(true);
      _invoiceList[indexEdit] = newInvoice;
      try {
        await _apiService.update(
            colect: Constants.invoiceDb, dataID: id, data: newInvoice.toMap());
      } catch (e) {
        print(e.toString());
      }

      notifyListeners();
    }
  }

  Future<void> updateStatus(String? id) async {
    try {
      await _apiService.update(
          colect: Constants.invoiceDb,
          dataID: id ?? '',
          data: {'isPayment': true});
    } catch (e) {
      print(e.toString());
    }
  }

  //find invoice by id
  InvoiceModel findInvoiceById(String id) =>
      _invoiceList.firstWhere((element) => element.id == id);

  double electTotal(String date) {
    double total = 0;
    for (var i = 0; i < _invoiceList.length; i++) {
      if (_invoiceList[i].isPayment!) {
        total += invoiceList[i].priceEclect ?? 0;
      }
    }
    return total;
  }

  double waterTotal(String date) {
    double _waterTotal = 0;
    for (var i = 0; i < _invoiceList.length; i++) {
      if (_invoiceList[i].isPayment!) {
        _waterTotal += invoiceList[i].waterCost ?? 0;
      }
    }
    return _waterTotal;
  }

  double roomTotal(String date) {
    double total = 0;
    for (var i = 0; i < _invoiceList.length; i++) {
      if (_invoiceList[i].isPayment!) {
        total += invoiceList[i].roomCost ?? 0;
      }
    }
    return total;
  }

  double moreService(String date) {
    double total = 0;
    for (var i = 0; i < _invoiceList.length; i++) {
      if (_invoiceList[i].isPayment!) {
        total += invoiceList[i].priceMoreService ?? 0;
      }
    }
    return total;
  }
}
