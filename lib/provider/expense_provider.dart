import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/expense_model.dart';

class Expense with ChangeNotifier, Helper {
  // process
  bool? _isLoading;
  bool get showLoading => _isLoading ?? false;
  // String? _errorMessage;
  // String get errorMessage => _errorMessage ?? '';
  List<ExpenseModel> _expenseList = [];
  List<ExpenseModel> get expenseList => _expenseList;
  final userUID = FirebaseAuth.instance.currentUser?.uid;
  QuerySnapshot? snapshot;

  // api service
  final _apiService = ApiService();

  Future<void> addExpense(ExpenseModel expenseModel) async {
    var newExpense = ExpenseModel(
      id: expenseModel.id,
      name: expenseModel.name,
      price: expenseModel.price,
      note: expenseModel.note,
      date: expenseModel.date,
    );
    _expenseList.add(newExpense);
    notifyListeners();
    try {
      await _apiService.create(
        colect: Constants.expenseDb,
        dataID: expenseModel.id ?? '',
        data: newExpense.toMap(),
      );
    } catch (e) {}
  }

  Future<void> getAllExpense() async {
    List<ExpenseModel> listExtract = [];

    _isLoading = isLoading(true);
    snapshot = await _apiService.getData(colect: Constants.expenseDb);
    _isLoading = isLoading(false);
    if (snapshot != null) {
      for (var docs in snapshot!.docs) {
        listExtract
            .add(ExpenseModel.fromMap(docs.data() as Map<String, dynamic>));
      }
    }
    _expenseList = listExtract;
    notifyListeners();
  }

  List<ExpenseModel> getExpenseByMonth({required String month}) {
    List<ExpenseModel> listExpense = [];
    for (var expense in _expenseList) {
      if (expense.date == month) {
        listExpense.add(expense);
      }
    }
    return listExpense;
  }

  Future<void> deleteCustomer(String id) async {
    final existingExpense = _expenseList.indexWhere((prod) => prod.id == id);

    _expenseList.remove(existingExpense);
    notifyListeners();
    try {
      await _apiService.delete(colect: Constants.expenseDb, dataID: id);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> onRefesh() async {
    getAllExpense();
  }
}
