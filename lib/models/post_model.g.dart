// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['id'] as String?,
    json['content'] as String?,
    json['created'] as String?,
    (json['replies'] as List<dynamic>?)
        ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['image_url'] as String?,
    json['group'] == null
        ? null
        : Group.fromJson(json['group'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'created': instance.created,
      'replies': instance.replies,
      'user': instance.user,
      'image_url': instance.imageUrl,
      'group': instance.group,
    };
