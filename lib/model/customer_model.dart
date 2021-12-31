import 'dart:convert';

class CustomerModel {
  final String? id;
  final String? idFloor;
  final String? idRoom;
  final String? name;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? cardNumber;
  final String? email;
  final String? address;
  final String? roomNumber;
  final String? floorNumber;
  final String? imageFirstUrl;
  final String? imageLastUrl;
  final String? gender;
  final bool? status;
  CustomerModel({
    this.id,
    this.idFloor,
    this.idRoom,
    this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.cardNumber,
    this.email,
    this.address,
    this.roomNumber,
    this.floorNumber,
    this.imageFirstUrl,
    this.imageLastUrl,
    this.gender,
    this.status,
  });

  CustomerModel copyWith({
    String? id,
    String? idFloor,
    String? idRoom,
    String? name,
    String? phoneNumber,
    String? dateOfBirth,
    String? cardNumber,
    String? email,
    String? address,
    String? roomNumber,
    String? floorNumber,
    String? imageFirstUrl,
    String? imageLastUrl,
    String? gender,
    bool? status,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      idFloor: idFloor ?? this.idFloor,
      idRoom: idRoom ?? this.idRoom,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      cardNumber: cardNumber ?? this.cardNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      roomNumber: roomNumber ?? this.roomNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      imageFirstUrl: imageFirstUrl ?? this.imageFirstUrl,
      imageLastUrl: imageLastUrl ?? this.imageLastUrl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idFloor': idFloor,
      'idRoom': idRoom,
      'name': name,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'cardNumber': cardNumber,
      'email': email,
      'address': address,
      'roomNumber': roomNumber,
      'floorNumber': floorNumber,
      'imageFirstUrl': imageFirstUrl,
      'imageLastUrl': imageLastUrl,
      'gender': gender,
      'status': status,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      idFloor: map['idFloor'],
      idRoom: map['idRoom'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      dateOfBirth: map['dateOfBirth'],
      cardNumber: map['cardNumber'],
      email: map['email'],
      address: map['address'],
      roomNumber: map['roomNumber'],
      floorNumber: map['floorNumber'],
      imageFirstUrl: map['imageFirstUrl'],
      imageLastUrl: map['imageLastUrl'],
      gender: map['gender'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, idFloor: $idFloor, idRoom: $idRoom, name: $name, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, cardNumber: $cardNumber, email: $email, address: $address, roomNumber: $roomNumber, floorNumber: $floorNumber, imageFirstUrl: $imageFirstUrl, imageLastUrl: $imageLastUrl, gender: $gender, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.id == id &&
        other.idFloor == idFloor &&
        other.idRoom == idRoom &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.cardNumber == cardNumber &&
        other.email == email &&
        other.address == address &&
        other.roomNumber == roomNumber &&
        other.floorNumber == floorNumber &&
        other.imageFirstUrl == imageFirstUrl &&
        other.imageLastUrl == imageLastUrl &&
        other.gender == gender &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFloor.hashCode ^
        idRoom.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode ^
        cardNumber.hashCode ^
        email.hashCode ^
        address.hashCode ^
        roomNumber.hashCode ^
        floorNumber.hashCode ^
        imageFirstUrl.hashCode ^
        imageLastUrl.hashCode ^
        gender.hashCode ^
        status.hashCode;
  }
}
