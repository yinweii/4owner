import 'dart:convert';

class CustomerModel {
  final String? id;
  final String? idfloor;
  final String? idroom;
  final String? name;
  final String? phonenumber;
  final String? dateOfBirth;
  final String? cardnumber;
  final String? email;
  final String? address;
  final String? roomnumber;
  final String? floornumber;
  final String? imagefirsturl;
  final String? imagelasturl;
  final String? gender;
  final String? status;
  final bool? isholder;
  CustomerModel({
    this.id,
    this.idfloor,
    this.idroom,
    this.name,
    this.phonenumber,
    this.dateOfBirth,
    this.cardnumber,
    this.email,
    this.address,
    this.roomnumber,
    this.floornumber,
    this.imagefirsturl,
    this.imagelasturl,
    this.gender,
    this.status,
    this.isholder,
  });

  CustomerModel copyWith({
    String? id,
    String? idfloor,
    String? idroom,
    String? name,
    String? phonenumber,
    String? dateOfBirth,
    String? cardnumber,
    String? email,
    String? address,
    String? roomnumber,
    String? floornumber,
    String? imagefirsturl,
    String? imagelasturl,
    String? gender,
    String? status,
    bool? isholder,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      idfloor: idfloor ?? this.idfloor,
      idroom: idroom ?? this.idroom,
      name: name ?? this.name,
      phonenumber: phonenumber ?? this.phonenumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      cardnumber: cardnumber ?? this.cardnumber,
      email: email ?? this.email,
      address: address ?? this.address,
      roomnumber: roomnumber ?? this.roomnumber,
      floornumber: floornumber ?? this.floornumber,
      imagefirsturl: imagefirsturl ?? this.imagefirsturl,
      imagelasturl: imagelasturl ?? this.imagelasturl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      isholder: isholder ?? this.isholder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idfloor': idfloor,
      'idroom': idroom,
      'name': name,
      'phonenumber': phonenumber,
      'dateOfBirth': dateOfBirth,
      'cardnumber': cardnumber,
      'email': email,
      'address': address,
      'roomnumber': roomnumber,
      'floornumber': floornumber,
      'imagefirsturl': imagefirsturl,
      'imagelasturl': imagelasturl,
      'gender': gender,
      'status': status,
      'isholder': isholder,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      idfloor: map['idfloor'],
      idroom: map['idroom'],
      name: map['name'],
      phonenumber: map['phonenumber'],
      dateOfBirth: map['dateOfBirth'],
      cardnumber: map['cardnumber'],
      email: map['email'],
      address: map['address'],
      roomnumber: map['roomnumber'],
      floornumber: map['floornumber'],
      imagefirsturl: map['imagefirsturl'],
      imagelasturl: map['imagelasturl'],
      gender: map['gender'],
      status: map['status'],
      isholder: map['isholder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, idfloor: $idfloor, idroom: $idroom, name: $name, phonenumber: $phonenumber, dateOfBirth: $dateOfBirth, cardnumber: $cardnumber, email: $email, address: $address, roomnumber: $roomnumber, floornumber: $floornumber, imagefirsturl: $imagefirsturl, imagelasturl: $imagelasturl, gender: $gender, status: $status, isholder: $isholder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.id == id &&
        other.idfloor == idfloor &&
        other.idroom == idroom &&
        other.name == name &&
        other.phonenumber == phonenumber &&
        other.dateOfBirth == dateOfBirth &&
        other.cardnumber == cardnumber &&
        other.email == email &&
        other.address == address &&
        other.roomnumber == roomnumber &&
        other.floornumber == floornumber &&
        other.imagefirsturl == imagefirsturl &&
        other.imagelasturl == imagelasturl &&
        other.gender == gender &&
        other.status == status &&
        other.isholder == isholder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idfloor.hashCode ^
        idroom.hashCode ^
        name.hashCode ^
        phonenumber.hashCode ^
        dateOfBirth.hashCode ^
        cardnumber.hashCode ^
        email.hashCode ^
        address.hashCode ^
        roomnumber.hashCode ^
        floornumber.hashCode ^
        imagefirsturl.hashCode ^
        imagelasturl.hashCode ^
        gender.hashCode ^
        status.hashCode ^
        isholder.hashCode;
  }
}
