import 'package:dio/dio.dart';
import 'package:ktu_sosyal/models/post_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';
import 'package:ktu_sosyal/services/token_service.dart';

class UserRepository {
  List<Post> posts = <Post>[];
  Dio dio = Dio();
  TokenService tokenService = TokenService();
  Future getUser(String userId) async {
    User user;
    Response responseUser = await dio.get(
      'http://51.138.78.233/api/users/$userId/',
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (responseUser.statusCode == 200) {}
    Response responsePost = await dio.get(
      'http://51.138.78.233/api/users/$userId/posts/',
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (responsePost.statusCode == 200) {}
    for (Map<String, dynamic> post in responsePost.data) {
      Post newPost = Post.fromJson(post);
      posts.add(newPost);
    }

    user = User.fromJson(responseUser.data);

    return user;
  }
}
