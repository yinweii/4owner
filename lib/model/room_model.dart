import 'package:json_annotation/json_annotation.dart';
part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String? id;
  final String? idFloor;
  final String? name;
  final String? note;
  final int? floorNumber;
  final double? price;
  final double? depositPrice;
  final int? people;
  final double? area;

  RoomModel(
      {this.id,
      this.idFloor,
      this.name,
      this.note,
      this.floorNumber,
      this.price,
      this.depositPrice,
      this.people,
      this.area});

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
