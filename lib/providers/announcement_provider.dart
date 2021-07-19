import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/announcement_model.dart';
import 'package:ktu_sosyal/repositories/announcement_repository.dart';

class AnnouncementProvider with ChangeNotifier {
  List<Announcement> _announcements = [];

  List<Announcement> get announcements => _announcements;

  Future<void> getAnnouncements() async {
    AnnouncementRepository announcementRepository = AnnouncementRepository();
    _announcements = await announcementRepository.getAnnouncement();
    notifyListeners();
  }
}
