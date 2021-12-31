import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:owner_app/model/room_model.dart';

class FloorModel {
  final String? id;
  final String? name;
  final String? desc;
  final List<RoomModel>? roomList;
  FloorModel({
    this.id,
    this.name,
    this.desc,
    this.roomList,
  });

  FloorModel copyWith({
    String? id,
    String? name,
    String? desc,
    List<RoomModel>? roomList,
  }) {
    return FloorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      roomList: roomList ?? this.roomList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'roomList': roomList?.map((x) => x.toMap()).toList(),
    };
  }

  factory FloorModel.fromMap(Map<String, dynamic> map) {
    return FloorModel(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      roomList: map['roomList'] != null
          ? List<RoomModel>.from(
              map['roomList']?.map((x) => RoomModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FloorModel.fromJson(String source) =>
      FloorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FloorModel(id: $id, name: $name, desc: $desc, roomList: $roomList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FloorModel &&
        other.id == id &&
        other.name == name &&
        other.desc == desc &&
        listEquals(other.roomList, roomList);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ desc.hashCode ^ roomList.hashCode;
  }
}
