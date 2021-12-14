import 'dart:convert';

class RoomService {
  final String? id;
  final String? name;
  final double? price;
  final String? status;
  final String? note;
  RoomService({
    this.id,
    this.name,
    this.price,
    this.status,
    this.note,
  });

  RoomService copyWith({
    String? id,
    String? name,
    double? price,
    String? status,
    String? note,
  }) {
    return RoomService(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'status': status,
      'note': note,
    };
  }

  factory RoomService.fromMap(Map<String, dynamic> map) {
    return RoomService(
      id: map['id'],
      name: map['name'],
      price: map['price']?.toDouble(),
      status: map['status'],
      note: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomService.fromJson(String source) =>
      RoomService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomService(id: $id, name: $name, price: $price, status: $status, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomService &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.status == status &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        status.hashCode ^
        note.hashCode;
  }
}

List<RoomService> listRooom = [
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
  RoomService(id: '1', name: 'meo1', price: 20, status: 'free', note: 'thang'),
];
