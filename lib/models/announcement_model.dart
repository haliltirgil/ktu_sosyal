import 'package:json_annotation/json_annotation.dart';

part 'announcement_model.g.dart';

@JsonSerializable()
class Announcement {
  final String? title;
  final String? link;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Announcement( this.title, this.link);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
