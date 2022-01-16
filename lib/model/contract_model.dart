import 'dart:convert';

class ContractModel {
  final String? id;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String? idCustomer;
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
    this.idCustomer,
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
    String? idCustomer,
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
      idCustomer: idCustomer ?? this.idCustomer,
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
      'createAt': createAt?.millisecondsSinceEpoch,
      'updateAt': updateAt?.millisecondsSinceEpoch,
      'idCustomer': idCustomer,
      'dateFrom': dateFrom?.millisecondsSinceEpoch,
      'dateTo': dateTo?.millisecondsSinceEpoch,
      'startPay': startPay?.millisecondsSinceEpoch,
      'deposit': deposit,
      'numberPerson': numberPerson,
      'status': status,
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
      idCustomer: map['idCustomer'],
      dateFrom: map['dateFrom'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateFrom'])
          : null,
      dateTo: map['dateTo'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTo'])
          : null,
      startPay: map['startPay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startPay'])
          : null,
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
    return 'ContractModel(id: $id, createAt: $createAt, updateAt: $updateAt, idCustomer: $idCustomer, dateFrom: $dateFrom, dateTo: $dateTo, startPay: $startPay, deposit: $deposit, numberPerson: $numberPerson, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContractModel &&
        other.id == id &&
        other.createAt == createAt &&
        other.updateAt == updateAt &&
        other.idCustomer == idCustomer &&
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
        idCustomer.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        startPay.hashCode ^
        deposit.hashCode ^
        numberPerson.hashCode ^
        status.hashCode;
  }
}
