import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/invoice_model.dart';
import 'package:owner_app/model/more_service_model.dart';
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
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.invoiceDb)
          .doc(invoice.id)
          .set(newInvoice.toMap());
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

  Future<void> getAllInvoiceOutDate() async {
    try {
      _isLoading = isLoading(true);
      snapshot = await _fireStore
          .collection(Constants.userDb) //
          .doc(userUID)
          .collection(Constants.invoiceDb)
          .where('isPayment', isEqualTo: false)
          .where('dateTo',
              isGreaterThanOrEqualTo:
                  DateTime.now().millisecondsSinceEpoch.toString())
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
        _fireStore
            .collection(Constants.userDb)
            .doc(userUID)
            .collection(Constants.invoiceDb)
            .doc(id)
            .update(newInvoice.toMap());
      } catch (e) {
        print(e.toString());
      }

      notifyListeners();
    }
  }

  Future<void> updateStatus(String? id) async {
    try {
      _fireStore
          .collection(Constants.userDb)
          .doc(userUID)
          .collection(Constants.invoiceDb)
          .doc(id)
          .update({'isPayment': true});
    } catch (e) {
      print(e.toString());
    }
  }

  //find invoice by id
  InvoiceModel findInvoiceById(String id) =>
      _invoiceList.firstWhere((element) => element.id == id);
}
