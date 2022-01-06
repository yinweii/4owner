import 'dart:convert';

class RoomHolderModel {
  final String? id;
  final String customerId;
  final String customerName;
  final double? depositCost;
  final String? idFloor;
  final String? idRoom;
  final String? roomNumber;
  final String? floorNumber;
  final String? status;
  final String? payment;
  final DateTime? startTime;
  RoomHolderModel({
    this.id,
    required this.customerId,
    required this.customerName,
    this.depositCost,
    this.idFloor,
    this.idRoom,
    this.roomNumber,
    this.floorNumber,
    this.status,
    this.payment,
    this.startTime,
  });

  RoomHolderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    double? depositCost,
    String? idFloor,
    String? idRoom,
    String? roomNumber,
    String? floorNumber,
    String? status,
    String? payment,
    DateTime? startTime,
  }) {
    return RoomHolderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      depositCost: depositCost ?? this.depositCost,
      idFloor: idFloor ?? this.idFloor,
      idRoom: idRoom ?? this.idRoom,
      roomNumber: roomNumber ?? this.roomNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      status: status ?? this.status,
      payment: payment ?? this.payment,
      startTime: startTime ?? this.startTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'depositCost': depositCost,
      'idFloor': idFloor,
      'idRoom': idRoom,
      'roomNumber': roomNumber,
      'floorNumber': floorNumber,
      'status': status,
      'payment': payment,
      'startTime': startTime?.millisecondsSinceEpoch,
    };
  }

  factory RoomHolderModel.fromMap(Map<String, dynamic> map) {
    return RoomHolderModel(
      id: map['id'],
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      depositCost: map['depositCost']?.toDouble(),
      idFloor: map['idFloor'],
      idRoom: map['idRoom'],
      roomNumber: map['roomNumber'],
      floorNumber: map['floorNumber'],
      status: map['status'],
      payment: map['payment'],
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomHolderModel.fromJson(String source) =>
      RoomHolderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomHolderModel(id: $id, customerId: $customerId, customerName: $customerName, depositCost: $depositCost, idFloor: $idFloor, idRoom: $idRoom, roomNumber: $roomNumber, floorNumber: $floorNumber, status: $status, payment: $payment, startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomHolderModel &&
        other.id == id &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.depositCost == depositCost &&
        other.idFloor == idFloor &&
        other.idRoom == idRoom &&
        other.roomNumber == roomNumber &&
        other.floorNumber == floorNumber &&
        other.status == status &&
        other.payment == payment &&
        other.startTime == startTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        customerName.hashCode ^
        depositCost.hashCode ^
        idFloor.hashCode ^
        idRoom.hashCode ^
        roomNumber.hashCode ^
        floorNumber.hashCode ^
        status.hashCode ^
        payment.hashCode ^
        startTime.hashCode;
  }
}
