import 'dart:convert';

class ExpenseModel {
  final String? id;
  final String? name;
  final double? price;
  final String? note;
  final String? date;
  ExpenseModel({
    this.id,
    this.name,
    this.price,
    this.note,
    this.date,
  });

  ExpenseModel copyWith({
    String? id,
    String? name,
    double? price,
    String? note,
    String? date,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'note': note,
      'date': date,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      name: map['name'],
      price: map['price']?.toDouble(),
      note: map['note'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(id: $id, name: $name, price: $price, note: $note, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.note == note &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        note.hashCode ^
        date.hashCode;
  }
}
