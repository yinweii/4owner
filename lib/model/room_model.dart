import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/provider/customer_provider.dart';

class RoomModel {
  final String? id;
  final String? idfloor;
  final String? roomname;
  final double? area;
  final double? price;
  final String? status;
  final String? limidperson;
  final String? note;
  final String? floorname;
  RoomModel({
    this.id,
    this.idfloor,
    this.roomname,
    this.area,
    this.price,
    this.status,
    this.limidperson,
    this.note,
    this.floorname,
  });

  RoomModel copyWith({
    String? id,
    String? idfloor,
    String? roomname,
    double? area,
    double? price,
    String? status,
    String? limidperson,
    String? note,
    String? floorname,
  }) {
    return RoomModel(
      id: id ?? this.id,
      idfloor: idfloor ?? this.idfloor,
      roomname: roomname ?? this.roomname,
      area: area ?? this.area,
      price: price ?? this.price,
      status: status ?? this.status,
      limidperson: limidperson ?? this.limidperson,
      note: note ?? this.note,
      floorname: floorname ?? this.floorname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idfloor': idfloor,
      'roomname': roomname,
      'area': area,
      'price': price,
      'status': status,
      'limidperson': limidperson,
      'note': note,
      'floorname': floorname,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      idfloor: map['idfloor'],
      roomname: map['roomname'],
      area: map['area']?.toDouble(),
      price: map['price']?.toDouble(),
      status: map['status'],
      limidperson: map['limidperson'],
      note: map['note'],
      floorname: map['floorname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, idfloor: $idfloor, roomname: $roomname, area: $area, price: $price, status: $status, limidperson: $limidperson, note: $note, floorname: $floorname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.idfloor == idfloor &&
        other.roomname == roomname &&
        other.area == area &&
        other.price == price &&
        other.status == status &&
        other.limidperson == limidperson &&
        other.note == note &&
        other.floorname == floorname;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idfloor.hashCode ^
        roomname.hashCode ^
        area.hashCode ^
        price.hashCode ^
        status.hashCode ^
        limidperson.hashCode ^
        note.hashCode ^
        floorname.hashCode;
  }
}
