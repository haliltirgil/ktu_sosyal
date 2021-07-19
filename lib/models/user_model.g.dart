// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String?,
    json['surname'] as String?,
    json['id'] as String?,
    json['email'] as String?,
    json['schoolNo'] as String?,
    json['photo_url'] as String?,
    json['fieldOfStudy'] as String?,
    (json['groups'] as List<dynamic>?)
        ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'id': instance.id,
      'email': instance.email,
      'schoolNo': instance.schoolNo,
      'photo_url': instance.photoURL,
      'groups': instance.groups,
      'fieldOfStudy': instance.fieldOfStudy,
    };
