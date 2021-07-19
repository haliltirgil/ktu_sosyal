import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostRequest {
  final String content;
  @JsonKey(name: "photo_url")
  final String? photoUrl;

  PostRequest(this.content, {String? photoUrl}) : photoUrl = photoUrl;

  factory PostRequest.fromJson(Map<String, dynamic> json) =>
      _$PostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestToJson(this);
}
