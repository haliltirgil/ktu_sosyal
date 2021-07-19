import 'package:dio/dio.dart';
import 'package:ktu_sosyal/models/announcement_model.dart';

class AnnouncementRepository {
  Dio dio = Dio();

  Future<List<Announcement>> getAnnouncement() async {
    List<Announcement> announcements = [];
    Response response;
    response = await dio.get(
      'http://51.138.78.233/api/announcements',
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    for (Map<String, dynamic> announcement in response.data) {
      announcements.add(Announcement.fromJson(announcement));
    }

    return announcements;
  }
}
