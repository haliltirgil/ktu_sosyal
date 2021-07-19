import 'package:json_annotation/json_annotation.dart';
import 'package:ktu_sosyal/models/user_model.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class Reply {
  final String? id;
  final String? content;
  final String? created;
  final User? user;

  Reply(this.id, this.content, this.created, this.user);

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
