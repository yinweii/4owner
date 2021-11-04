import 'package:json_annotation/json_annotation.dart';
part 'floor_model.g.dart';

@JsonSerializable()
class FloorModel {
  final String? id;
  final String? name;
  final String? desc;

  FloorModel({this.id, this.name, this.desc});

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
  @override
  // ignore: unnecessary_overrides
  String toString() {
    return '''FLOOR:{ id: $id , name: $name , desc: $desc }''';
  }
}

List<FloorModel> listFloor = [
  FloorModel(id: '1', name: 'Tang 1'),
  FloorModel(id: '2', name: 'Tang 2'),
  FloorModel(id: '3', name: 'Tang 3'),
  FloorModel(id: '4', name: 'Tang 4'),
  FloorModel(id: '5', name: 'Tang 5'),
];
