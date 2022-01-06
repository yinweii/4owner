import 'dart:convert';

class ElectModel {
  final double? lastNumber;
  final double? currentNumber;
  final double? unitPrice;
  ElectModel({
    this.lastNumber,
    this.currentNumber,
    this.unitPrice,
  });

  ElectModel copyWith({
    double? lastNumber,
    double? currentNumber,
    double? unitPrice,
  }) {
    return ElectModel(
      lastNumber: lastNumber ?? this.lastNumber,
      currentNumber: currentNumber ?? this.currentNumber,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lastNumber': lastNumber,
      'currentNumber': currentNumber,
      'unitPrice': unitPrice,
    };
  }

  factory ElectModel.fromMap(Map<String, dynamic> map) {
    return ElectModel(
      lastNumber: map['lastNumber']?.toDouble(),
      currentNumber: map['currentNumber']?.toDouble(),
      unitPrice: map['unitPrice']?.toDouble(),
    );
  }

  @override
  String toString() =>
      'ElectModel(lastNumber: $lastNumber, currentNumber: $currentNumber, unitPrice: $unitPrice)';
}

class WaterModel {
  final double? lastNumber;
  final double? currentNumber;
  final double? unitPrice;

  WaterModel({this.lastNumber, this.currentNumber, this.unitPrice});

  WaterModel copyWith({
    double? lastNumber,
    double? currentNumber,
    double? unitPrice,
  }) {
    return WaterModel(
      lastNumber: lastNumber ?? this.lastNumber,
      currentNumber: currentNumber ?? this.currentNumber,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lastNumber': lastNumber,
      'currentNumber': currentNumber,
      'unitPrice': unitPrice,
    };
  }

  factory WaterModel.fromMap(Map<String, dynamic> map) {
    return WaterModel(
      lastNumber: map['lastNumber']?.toDouble(),
      currentNumber: map['currentNumber']?.toDouble(),
      unitPrice: map['unitPrice']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WaterModel.fromJson(String source) =>
      WaterModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'WaterModel(lastNumber: $lastNumber, currentNumber: $currentNumber, unitPrice: $unitPrice)';
}
