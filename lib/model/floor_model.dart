import 'dart:convert';

class FloorModel {
  final String? id;
  final String? name;
  final String? desc;
  FloorModel({
    this.id,
    this.name,
    this.desc,
  });

  FloorModel copyWith({
    String? id,
    String? name,
    String? desc,
  }) {
    return FloorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
    };
  }

  factory FloorModel.fromMap(Map<String, dynamic> map) {
    return FloorModel(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FloorModel.fromJson(String source) =>
      FloorModel.fromMap(json.decode(source));

  @override
  String toString() => 'FloorModel(id: $id, name: $name, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FloorModel &&
        other.id == id &&
        other.name == name &&
        other.desc == desc;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ desc.hashCode;
}
