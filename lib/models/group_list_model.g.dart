// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupList _$GroupListFromJson(Map<String, dynamic> json) {
  return GroupList(
    (json['groups'] as List<dynamic>?)
        ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GroupListToJson(GroupList instance) => <String, dynamic>{
      'groups': instance.groups,
    };
