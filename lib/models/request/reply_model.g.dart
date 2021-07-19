// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyRequest _$ReplyRequestFromJson(Map<String, dynamic> json) {
  return ReplyRequest(
    json['content'] as String,
    json['user_Id'] as String,
  );
}

Map<String, dynamic> _$ReplyRequestToJson(ReplyRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'user_Id': instance.user_Id,
    };
