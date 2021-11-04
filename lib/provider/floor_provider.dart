import 'package:flutter/foundation.dart';
import 'package:owner_app/model/floor_model.dart';

class Floor with ChangeNotifier {
  // process
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage ?? '';
  //list floor
  final List<FloorModel> _floorList = [];
  List<FloorModel> get floorList => _floorList;

  void addNewFloor(FloorModel newFlow) {
    _floorList.add(newFlow);
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}
