import 'package:json_annotation/json_annotation.dart';
import 'package:ktu_sosyal/models/group_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String? name;

  final String? surname;

  final String? id;

  final String? email;

  final String? schoolNo;

  @JsonKey(name:"photo_url")
  final String? photoURL;

  final List<Group>? groups;

  final String? fieldOfStudy;

  User(this.name, this.surname, this.id, this.email, this.schoolNo,
      this.photoURL,  this.fieldOfStudy, this.groups);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  
}
