import 'package:dio/dio.dart';
import 'package:ktu_sosyal/models/group_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';
import 'package:ktu_sosyal/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupRepository {
  TokenService tokenService = TokenService();
  Dio dio = Dio();

  Future<List<User>> getGroupMembers(String groupId) async {
    List<User> users = <User>[];
    User admin;
    Response response;
    response = await dio.get(
      'http://51.138.78.233/api/groups/$groupId',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    admin = User.fromJson(response.data["admins"][0]);
    users.add(admin);
    Group.fromJson(response.data).users!.forEach((user) {
      if (user.id != admin.id) {
        users.add(user);
      }
    });
    return users;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('auth-token'));
  }
}
