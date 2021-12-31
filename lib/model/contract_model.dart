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
  final double? price;
  final double? deposit;
  ContractModel({
    this.id,
    this.createAt,
    this.updateAt,
    this.customer,
    this.dateFrom,
    this.dateTo,
    this.startPay,
    this.price,
    this.deposit,
  });

  ContractModel copyWith({
    String? id,
    DateTime? createAt,
    DateTime? updateAt,
    CustomerModel? customer,
    DateTime? dateFrom,
    DateTime? dateTo,
    DateTime? startPay,
    double? price,
    double? deposit,
  }) {
    return ContractModel(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      customer: customer ?? this.customer,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      startPay: startPay ?? this.startPay,
      price: price ?? this.price,
      deposit: deposit ?? this.deposit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createAt': createAt?.millisecondsSinceEpoch,
      'updateAt': updateAt?.millisecondsSinceEpoch,
      'customer': customer?.toMap(),
      'dateFrom': dateFrom?.millisecondsSinceEpoch,
      'dateTo': dateTo?.millisecondsSinceEpoch,
      'startPay': startPay?.millisecondsSinceEpoch,
      'price': price,
      'deposit': deposit,
    };
  }

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      id: map['id'],
      createAt: map['createAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createAt'])
          : null,
      updateAt: map['updateAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updateAt'])
          : null,
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'])
          : null,
      dateFrom: map['dateFrom'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateFrom'])
          : null,
      dateTo: map['dateTo'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTo'])
          : null,
      startPay: map['startPay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startPay'])
          : null,
      price: map['price']?.toDouble(),
      deposit: map['deposit']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractModel.fromJson(String source) =>
      ContractModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContractModel(id: $id, createAt: $createAt, updateAt: $updateAt, customer: $customer, dateFrom: $dateFrom, dateTo: $dateTo, startPay: $startPay, price: $price, deposit: $deposit)';
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
        other.price == price &&
        other.deposit == deposit;
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
        price.hashCode ^
        deposit.hashCode;
  }
}
