import 'package:json_annotation/json_annotation.dart';
part 'service_model.g.dart';

@JsonSerializable()
class RoomService {
  final String? id;
  final String? name;
  final double? price;
  final String? status;
  final String? note;

  RoomService({this.id, this.name, this.price, this.status, this.note});

  factory RoomService.fromJson(Map<String, dynamic> json) =>
      _$RoomServiceFromJson(json);

  Map<String, dynamic> toJson() => _$RoomServiceToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return '''RomService: {id: $id,name: $name, price: $price , status: $status , note: $note} ''';
  }
}

List<RoomService> listRooom = [
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
];
