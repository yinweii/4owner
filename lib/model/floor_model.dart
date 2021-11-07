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
