import 'package:ktu_sosyal/models/post_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final List<User>? users;
  final String? name;
  final List<Post>? posts;
  final User? admin;


  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Group(this.id, this.users, this.name, this.posts, this.admin);


  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
