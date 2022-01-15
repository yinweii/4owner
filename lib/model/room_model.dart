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
  final String? limidPerson;
  final String? note;
  final int? person;
  RoomModel({
    this.id,
    this.idFloor,
    this.romName,
    this.area,
    this.price,
    this.status,
    this.limidPerson,
    this.note,
    this.person,
  });

  RoomModel copyWith({
    String? id,
    String? idFloor,
    String? romName,
    double? area,
    double? price,
    String? status,
    String? limidPerson,
    String? note,
    int? person,
  }) {
    return RoomModel(
      id: id ?? this.id,
      idFloor: idFloor ?? this.idFloor,
      romName: romName ?? this.romName,
      area: area ?? this.area,
      price: price ?? this.price,
      status: status ?? this.status,
      limidPerson: limidPerson ?? this.limidPerson,
      note: note ?? this.note,
      person: person ?? this.person,
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
      'limidPerson': limidPerson,
      'note': note,
      'person': person,
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
      limidPerson: map['limidPerson'],
      note: map['note'],
      person: map['person']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, idFloor: $idFloor, romName: $romName, area: $area, price: $price, status: $status, limidPerson: $limidPerson, note: $note, person: $person)';
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
        other.limidPerson == limidPerson &&
        other.note == note &&
        other.person == person;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFloor.hashCode ^
        romName.hashCode ^
        area.hashCode ^
        price.hashCode ^
        status.hashCode ^
        limidPerson.hashCode ^
        note.hashCode ^
        person.hashCode;
  }
}
