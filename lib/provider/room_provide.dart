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
      id: room.id,
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

  //find room by id
  RoomModel findRoomById(String? id) {
    return _listRoom.firstWhere((element) => element.id == id);
  }

  void editRoom(String id, RoomModel room) {
    final roomIndex = _listRoom.indexWhere((element) => element.id == id);
    var editRoom = RoomModel(
      id: id,
      romName: room.romName,
      area: room.area,
      price: room.price,
      person: room.person,
      note: room.note,
      imageUrl: '',
    );
    if (roomIndex >= 0) {
      _listRoom[roomIndex] = editRoom;
      notifyListeners();
    } else {
      return;
    }
  }

  void deleteRoom(String id) {
    final roomIndex = _listRoom.indexWhere((element) => element.id == id);
    _listRoom.removeAt(roomIndex);
    notifyListeners();
  }
}
