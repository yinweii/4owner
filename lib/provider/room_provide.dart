import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/model/room_model.dart';

class RoomProvider with ChangeNotifier {
  //list
  List<RoomModel> _listRoom = [];
  List<RoomModel> get listRoom => _listRoom;

  // add new room
  void addNewRoom(RoomModel room) {
    var newRoom = RoomModel(
      id: MinId.getId(),
      romName: room.romName,
      area: room.area,
      price: room.price,
      person: room.person,
      note: room.note,
      imageUrl: '',
    );
    _listRoom.add(newRoom);
    notifyListeners();
  }
}
