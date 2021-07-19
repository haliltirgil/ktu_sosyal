import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:ktu_sosyal/models/post_model.dart';
import 'package:ktu_sosyal/models/request/post_model.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/services/id_service.dart';
import 'package:ktu_sosyal/services/token_service.dart';
import 'package:provider/provider.dart';

class PostRepository {
  Dio dio = Dio();
  TokenService tokenService = TokenService();

  void getAllGroupPosts(String groupId) async {
    List<Post> posts = <Post>[];
    Response response;
    response = await dio.get(
      'http://51.138.78.233/api/groups/$groupId/posts',
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> post in response.data) {
        posts.add(Post.fromJson(post));
      }
    }
  }

  void deletePost(String postId, BuildContext context) async {
    Response response;
    IdService id = IdService();
    response = await dio.delete(
      'http://51.138.78.233/api/users/${await id.getId()}/posts/$postId',
      data: {'postId': postId},
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      Provider.of<AuthProvider>(context, listen: false).setHomePagePosts();
      Provider.of<AuthProvider>(context, listen: false).setMyPosts();
      return;
    }
  }

  // void getAllPosts() async {
  //   List<Post> posts = <Post>[];
  //   Response response;
  //   response = await dio.get(
  //     'http://51.138.78.233/api/posts',
  //     options: Options(
  //       headers: {'auth-token': await tokenService.getToken()},
  //       followRedirects: false,
  //       validateStatus: (status) {
  //         return status! < 500;
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     for (Map<String, dynamic> post in response.data) {
  //       posts.add(Post.fromJson(post));
  //     }
  //   }
  //   print('a');
  // }

  Future<String> createGroupPost(PostRequest post, String groupId) async {
    String? resultMessage;
    Response response;
    response = await dio.post(
      'http://51.138.78.233/api/groups/$groupId/posts',
      data: post.toJson(),
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );
    if (response.statusCode == 201)
      resultMessage = "Post Gonderme Basarili";
    else
      resultMessage = "Post Gonderme Basarisiz";
    return resultMessage;
  }

  Future<String> createUserPost(PostRequest post) async {
    String? resultMessage;
    Map<String, dynamic> payload =
        Jwt.parseJwt(await tokenService.getToken() ?? "");
    Response response;
    response = await dio.post(
      'http://51.138.78.233/api/users/${payload['id']}/posts',
      data: post.toJson(),
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201)
      resultMessage = "Post Gonderme Basarili";
    else
      resultMessage = "Post Gonderme Basarisiz";
    return resultMessage;
  }
}
