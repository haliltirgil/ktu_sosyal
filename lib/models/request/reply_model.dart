import 'package:json_annotation/json_annotation.dart';
part 'reply_model.g.dart';

@JsonSerializable()
class ReplyRequest {
  final String content;
  final String user_Id;
  
  ReplyRequest(this.content, this.user_Id);

  factory ReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$ReplyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyRequestToJson(this);
}
