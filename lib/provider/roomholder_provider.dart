import 'package:flutter/foundation.dart';
import 'package:owner_app/constants/loading_service.dart';
import 'package:owner_app/model/room_holder.dart';

class RoomHolder with ChangeNotifier, Helper {
  // process
  bool _isLoading = false;
  bool get showLoading => _isLoading;
  //list
  List<RoomHolderModel> _listHolder = [];
  List<RoomHolderModel> get listHolde => _listHolder;

  void addNewHolder(RoomHolderModel holder) {
    var newHolder = RoomHolderModel(
      id: holder.id,
      customerId: holder.customerId,
      depositCost: holder.depositCost,
      floorNumber: holder.floorNumber,
      idFloor: holder.idFloor,
      idRoom: holder.idRoom,
      payment: holder.payment,
      customerName: holder.customerName,
      roomNumber: holder.roomNumber,
      startTime: holder.startTime,
      status: holder.status,
    );
    _listHolder.add(newHolder);
    notifyListeners();
  }
}
