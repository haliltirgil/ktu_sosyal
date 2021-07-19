

import 'package:json_annotation/json_annotation.dart';
import 'package:ktu_sosyal/models/group_model.dart';

part 'group_list_model.g.dart';

@JsonSerializable()
class GroupList {
  final List<Group>? groups;

  GroupList(this.groups);

  factory GroupList.fromJson(Map<String, dynamic> json) => _$GroupListFromJson(json);


  Map<String, dynamic> toJson() => _$GroupListToJson(this);
}
