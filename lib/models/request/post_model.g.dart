// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRequest _$PostRequestFromJson(Map<String, dynamic> json) {
  return PostRequest(
    json['content'] as String,
    photoUrl: json['photo_url'] as String?,
  );
}

Map<String, dynamic> _$PostRequestToJson(PostRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'photo_url': instance.photoUrl,
    };
