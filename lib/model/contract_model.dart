import 'dart:convert';

import 'package:owner_app/model/customer_model.dart';

class ContractModel {
  final String? id;
  final DateTime? createAt;
  final DateTime? updateAt;
  final CustomerModel? customer;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final DateTime? startPay;
  final double? deposit;
  final int? numberPerson;
  bool? status = false;
  ContractModel({
    this.id,
    this.createAt,
    this.updateAt,
    this.customer,
    this.dateFrom,
    this.dateTo,
    this.startPay,
    this.deposit,
    this.numberPerson,
    this.status,
  });

  ContractModel copyWith({
    String? id,
    DateTime? createAt,
    DateTime? updateAt,
    CustomerModel? customer,
    DateTime? dateFrom,
    DateTime? dateTo,
    DateTime? startPay,
    double? deposit,
    int? numberPerson,
    bool? status,
  }) {
    return ContractModel(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      customer: customer ?? this.customer,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      startPay: startPay ?? this.startPay,
      deposit: deposit ?? this.deposit,
      numberPerson: numberPerson ?? this.numberPerson,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createAt': createAt,
      'updateAt': updateAt,
      'customer': customer?.toMap(),
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'startPay': startPay,
      'deposit': deposit,
      'numberPerson': numberPerson,
      'status': status,
    };
  }

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      id: map['id'],
      createAt: map['createAt'] != null ? map['createAt'].toDate() : null,
      updateAt: map['updateAt'] != null ? map['updateAt'].toDate() : null,
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'])
          : null,
      dateFrom: map['dateFrom'] != null ? map['dateFrom'].toDate() : null,
      dateTo: map['dateTo'] != null ? map['dateTo'].toDate() : null,
      startPay: map['startPay'] != null ? map['startPay'].toDate() : null,
      deposit: map['deposit']?.toDouble(),
      numberPerson: map['numberPerson']?.toInt(),
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractModel.fromJson(String source) =>
      ContractModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContractModel(id: $id, createAt: $createAt, updateAt: $updateAt, customer: $customer, dateFrom: $dateFrom, dateTo: $dateTo, startPay: $startPay, deposit: $deposit, numberPerson: $numberPerson, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContractModel &&
        other.id == id &&
        other.createAt == createAt &&
        other.updateAt == updateAt &&
        other.customer == customer &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.startPay == startPay &&
        other.deposit == deposit &&
        other.numberPerson == numberPerson &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createAt.hashCode ^
        updateAt.hashCode ^
        customer.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        startPay.hashCode ^
        deposit.hashCode ^
        numberPerson.hashCode ^
        status.hashCode;
  }
}
