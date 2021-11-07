import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? uid;
  final String? email;
  final String? name;

  UserModel({this.uid, this.email, this.name});
}
