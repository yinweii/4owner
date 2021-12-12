import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  final String? id;
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

  CustomerModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.dateOfBirth,
      this.cardNumber,
      this.email,
      this.address,
      this.roomNumber,
      this.gender,
      this.floorNumber,
      this.imageFirstUrl,
      this.imageLastUrl,
      this.status = true});

  @override
  String toString() {
    // TODO: implement toString
    return '''CUSTOMER: {id:  $id , name: $name, phoneNumber: $phoneNumber, floorNumber: $floorNumber ,
     dateOfBirth: $dateOfBirth, cardNumber: $cardNumber,email: $email, imageFirst: $imageFirstUrl, imageLast: $imageLastUrl , address: $address ,roomNumber: $roomNumber, gender: $gender  }''';
  }

  factory CustomerModel.formJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
