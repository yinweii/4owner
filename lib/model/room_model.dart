import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/provider/customer_provider.dart';

class RoomModel {
  final String? id;
  final String? idFloor;
  final String? romName;
  final double? area;
  final double? price;
  final String? status;
  final String? note;

  final String? imageUrl;
  final List<CustomerModel>? listCustomer;
  RoomModel({
    this.id,
    this.idFloor,
    this.romName,
    this.area,
    this.price,
    this.status,
    this.note,
    this.imageUrl,
    this.listCustomer,
  });

  RoomModel copyWith({
    String? id,
    String? idFloor,
    String? romName,
    double? area,
    double? price,
    String? status,
    String? note,
    String? imageUrl,
    List<CustomerModel>? listCustomer,
  }) {
    return RoomModel(
      id: id ?? this.id,
      idFloor: idFloor ?? this.idFloor,
      romName: romName ?? this.romName,
      area: area ?? this.area,
      price: price ?? this.price,
      status: status ?? this.status,
      note: note ?? this.note,
      imageUrl: imageUrl ?? this.imageUrl,
      listCustomer: listCustomer ?? this.listCustomer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idFloor': idFloor,
      'romName': romName,
      'area': area,
      'price': price,
      'status': status,
      'note': note,
      'imageUrl': imageUrl,
      'listCustomer': listCustomer?.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      idFloor: map['idFloor'],
      romName: map['romName'],
      area: map['area']?.toDouble(),
      price: map['price']?.toDouble(),
      status: map['status'],
      note: map['note'],
      imageUrl: map['imageUrl'],
      listCustomer: map['listCustomer'] != null
          ? List<CustomerModel>.from(
              map['listCustomer']?.map((x) => CustomerModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, idFloor: $idFloor, romName: $romName, area: $area, price: $price, status: $status, note: $note, imageUrl: $imageUrl, listCustomer: $listCustomer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.idFloor == idFloor &&
        other.romName == romName &&
        other.area == area &&
        other.price == price &&
        other.status == status &&
        other.note == note &&
        other.imageUrl == imageUrl &&
        listEquals(other.listCustomer, listCustomer);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFloor.hashCode ^
        romName.hashCode ^
        area.hashCode ^
        price.hashCode ^
        status.hashCode ^
        note.hashCode ^
        imageUrl.hashCode ^
        listCustomer.hashCode;
  }
}
