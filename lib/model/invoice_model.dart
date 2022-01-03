import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:owner_app/model/more_service_model.dart';
import 'package:owner_app/model/service_models.dart';

class InvoiceModel {
  final String? id;
  final String? idCustomer;
  final String? idRoom;
  final String? roomName;
  final String? name;
  final DateTime? invoiceDate;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final double? roomCost;
  final ElectModel? electUse;
  final double? priceEclect;
  final WaterModel? waterUse;
  final double? waterCost;
  final List<MoreServiceModel>? moreService;
  final double? priceMoreService;
  final double? total;
  final double? punishPrice;
  final double? discount;
  final double? totalAmount;
  bool? isPayment = false;
  InvoiceModel({
    this.id,
    this.idCustomer,
    this.idRoom,
    this.roomName,
    this.name,
    this.invoiceDate,
    this.dateFrom,
    this.dateTo,
    this.roomCost,
    this.electUse,
    this.priceEclect,
    this.waterUse,
    this.waterCost,
    this.moreService,
    this.priceMoreService,
    this.total,
    this.punishPrice,
    this.discount,
    this.totalAmount,
    required this.isPayment,
  });

  InvoiceModel copyWith({
    String? id,
    String? idCustomer,
    String? idRoom,
    String? roomName,
    String? name,
    DateTime? invoiceDate,
    DateTime? dateFrom,
    DateTime? dateTo,
    double? roomCost,
    ElectModel? electUse,
    double? priceEclect,
    WaterModel? waterUse,
    double? waterCost,
    List<MoreServiceModel>? moreService,
    double? priceMoreService,
    double? total,
    double? punishPrice,
    double? discount,
    double? totalAmount,
    bool? isPayment,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      idCustomer: idCustomer ?? this.idCustomer,
      idRoom: idRoom ?? this.idRoom,
      roomName: roomName ?? this.roomName,
      name: name ?? this.name,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      roomCost: roomCost ?? this.roomCost,
      electUse: electUse ?? this.electUse,
      priceEclect: priceEclect ?? this.priceEclect,
      waterUse: waterUse ?? this.waterUse,
      waterCost: waterCost ?? this.waterCost,
      moreService: moreService ?? this.moreService,
      priceMoreService: priceMoreService ?? this.priceMoreService,
      total: total ?? this.total,
      punishPrice: punishPrice ?? this.punishPrice,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      isPayment: isPayment ?? this.isPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCustomer': idCustomer,
      'idRoom': idRoom,
      'roomName': roomName,
      'name': name,
      'invoiceDate': invoiceDate?.millisecondsSinceEpoch,
      'dateFrom': dateFrom?.millisecondsSinceEpoch,
      'dateTo': dateTo?.millisecondsSinceEpoch,
      'roomCost': roomCost,
      'electUse': electUse?.toMap(),
      'priceEclect': priceEclect,
      'waterUse': waterUse?.toMap(),
      'waterCost': waterCost,
      'moreService': moreService?.map((x) => x.toMap()).toList(),
      'priceMoreService': priceMoreService,
      'total': total,
      'punishPrice': punishPrice,
      'discount': discount,
      'totalAmount': totalAmount,
      'isPayment': isPayment,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'],
      idCustomer: map['idCustomer'],
      idRoom: map['idRoom'],
      roomName: map['roomName'],
      name: map['name'],
      invoiceDate: map['invoiceDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['invoiceDate'])
          : null,
      dateFrom: map['dateFrom'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateFrom'])
          : null,
      dateTo: map['dateTo'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTo'])
          : null,
      roomCost: map['roomCost']?.toDouble(),
      electUse:
          map['electUse'] != null ? ElectModel.fromMap(map['electUse']) : null,
      priceEclect: map['priceEclect']?.toDouble(),
      waterUse:
          map['waterUse'] != null ? WaterModel.fromMap(map['waterUse']) : null,
      waterCost: map['waterCost']?.toDouble(),
      moreService: map['moreService'] != null
          ? List<MoreServiceModel>.from(
              map['moreService']?.map((x) => MoreServiceModel.fromMap(x)))
          : null,
      priceMoreService: map['priceMoreService']?.toDouble(),
      total: map['total']?.toDouble(),
      punishPrice: map['punishPrice']?.toDouble(),
      discount: map['discount']?.toDouble(),
      totalAmount: map['totalAmount']?.toDouble(),
      isPayment: map['isPayment'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InvoiceModel(id: $id, idCustomer: $idCustomer, idRoom: $idRoom, roomName: $roomName, name: $name, invoiceDate: $invoiceDate, dateFrom: $dateFrom, dateTo: $dateTo, roomCost: $roomCost, electUse: $electUse, priceEclect: $priceEclect, waterUse: $waterUse, waterCost: $waterCost, moreService: $moreService, priceMoreService: $priceMoreService, total: $total, punishPrice: $punishPrice, discount: $discount, totalAmount: $totalAmount, isPayment: $isPayment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceModel &&
        other.id == id &&
        other.idCustomer == idCustomer &&
        other.idRoom == idRoom &&
        other.roomName == roomName &&
        other.name == name &&
        other.invoiceDate == invoiceDate &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.roomCost == roomCost &&
        other.electUse == electUse &&
        other.priceEclect == priceEclect &&
        other.waterUse == waterUse &&
        other.waterCost == waterCost &&
        listEquals(other.moreService, moreService) &&
        other.priceMoreService == priceMoreService &&
        other.total == total &&
        other.punishPrice == punishPrice &&
        other.discount == discount &&
        other.totalAmount == totalAmount &&
        other.isPayment == isPayment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idCustomer.hashCode ^
        idRoom.hashCode ^
        roomName.hashCode ^
        name.hashCode ^
        invoiceDate.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        roomCost.hashCode ^
        electUse.hashCode ^
        priceEclect.hashCode ^
        waterUse.hashCode ^
        waterCost.hashCode ^
        moreService.hashCode ^
        priceMoreService.hashCode ^
        total.hashCode ^
        punishPrice.hashCode ^
        discount.hashCode ^
        totalAmount.hashCode ^
        isPayment.hashCode;
  }
}
