import 'dart:convert';

class RoomModel {
  final String? id;
  final String? romName;
  final double? area;
  final double? price;
  final String? status;
  final int? person;
  final String? note;
  final String? imageUrl;
  RoomModel({
    this.id,
    this.romName,
    this.area,
    this.price,
    this.status,
    this.person,
    this.note,
    this.imageUrl,
  });

  RoomModel copyWith({
    String? id,
    String? romName,
    double? area,
    double? price,
    String? status,
    int? person,
    String? note,
    String? imageUrl,
  }) {
    return RoomModel(
      id: id ?? this.id,
      romName: romName ?? this.romName,
      area: area ?? this.area,
      price: price ?? this.price,
      status: status ?? this.status,
      person: person ?? this.person,
      note: note ?? this.note,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'romName': romName,
      'area': area,
      'price': price,
      'status': status,
      'person': person,
      'note': note,
      'imageUrl': imageUrl,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      romName: map['romName'],
      area: map['area']?.toDouble(),
      price: map['price']?.toDouble(),
      status: map['status'],
      person: map['person']?.toInt(),
      note: map['note'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, romName: $romName, area: $area, price: $price, status: $status, person: $person, note: $note, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.romName == romName &&
        other.area == area &&
        other.price == price &&
        other.status == status &&
        other.person == person &&
        other.note == note &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        romName.hashCode ^
        area.hashCode ^
        price.hashCode ^
        status.hashCode ^
        person.hashCode ^
        note.hashCode ^
        imageUrl.hashCode;
  }
}
