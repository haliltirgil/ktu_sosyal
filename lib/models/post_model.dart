import 'package:json_annotation/json_annotation.dart';
import 'package:ktu_sosyal/models/group_model.dart';
import 'package:ktu_sosyal/models/reply_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final String? id;
  final String? content;
  final String? created;
  final List<Reply>? replies;
  final User? user;

  @JsonKey(name: "image_url")
  final String? imageUrl;
  final Group? group;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Post(this.id, this.content, this.created, this.replies, this.user,
      this.imageUrl, this.group);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
