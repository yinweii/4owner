import 'dart:convert';

import 'package:flutter/foundation.dart';

class MoreServiceModel {
  final String? id;
  final String? name;
  final String? note;
  final double? price;
  MoreServiceModel({
    this.id,
    this.name,
    this.note,
    this.price,
  });

  MoreServiceModel copyWith({
    String? id,
    String? name,
    String? note,
    double? price,
  }) {
    return MoreServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'price': price,
    };
  }

  factory MoreServiceModel.fromMap(Map<String, dynamic> map) {
    return MoreServiceModel(
      id: map['id'],
      name: map['name'],
      note: map['note'],
      price: map['price']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoreServiceModel.fromJson(String source) =>
      MoreServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoreServiceModel(id: $id, name: $name, note: $note, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoreServiceModel &&
        other.id == id &&
        other.name == name &&
        other.note == note &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ note.hashCode ^ price.hashCode;
  }
}

// more service change notifier
class MoreService with ChangeNotifier {
  List<MoreServiceModel> _moreServiceList = [];
  List<MoreServiceModel> get moreServiceList => _moreServiceList;

  double _total = 0.0;
  double? get total => _total;

  //get total
  double? getTotal() {
    double totalget = 0;
    _moreServiceList.forEach((element) {
      totalget += element.price ?? 0;
    });
    _total = totalget;

    print('TOTAL: $_total');
    return _total;
  }

  void addNewService(MoreServiceModel service) {
    var newService = MoreServiceModel(
      id: service.id,
      name: service.name,
      note: service.note,
      price: service.price,
    );
    _moreServiceList.add(newService);
    notifyListeners();
  }
}
