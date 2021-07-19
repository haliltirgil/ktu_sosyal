import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/post_model.dart';
import 'package:ktu_sosyal/models/user_model.dart';
import 'package:ktu_sosyal/services/id_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class AuthProvider with ChangeNotifier {
  var dio = Dio();
  bool? _isSignedIn;
  List<Post> _homePagePosts = <Post>[];
  List<Post> _myPosts = <Post>[];
  late User currentUser;
  bool get isSignedIn => _isSignedIn!;
  List<Post> get homePagePosts => _homePagePosts;
  List<Post> get myPosts => _myPosts;

  Future<bool> signIn(String email, String password) async {
    Response response;

    var dio = Dio();
    response = await dio.post('http://51.138.78.233/api/auth/login',
        options: Options(
          //headers: {'auth-token': await getToken()},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
        data: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth-token', response.data['token']);
      _isSignedIn = true;
      notifyListeners();
      await setCurrentUser();
      return true;
    }
    return false;
  }

  Future<void> setHomePagePosts() async {
    Response response;
    IdService id = IdService();
    //REMINDER: get user id is the line 47
    response = await dio.get(
      'http://51.138.78.233/api/users/${await id.getId()}/homepage',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      _homePagePosts.removeRange(0, _homePagePosts.length);
      for (Map<String, dynamic> post in response.data) {
        Post newPost = Post.fromJson(post);
        _homePagePosts.add(newPost);
      }
    }
    notifyListeners();
  }

  Future<void> setMyPosts() async {
    Response response;
    IdService id = IdService();
    //REMINDER: get user id is the line 47
    response = await dio.get(
      'http://51.138.78.233/api/users/${await id.getId()}/posts',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      _myPosts.removeRange(0, _myPosts.length);
      for (Map<String, dynamic> post in response.data) {
        Post newPost = Post.fromJson(post);
        _myPosts.add(newPost);
      }
    }
    notifyListeners();
  }

  Future<void> setCurrentUser() async {
    Response response;
    IdService id = IdService();
    //REMINDER: get user id is the line 47
    response = await dio.get(
      'http://51.138.78.233/api/users/${await id.getId()}/',
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    currentUser = User.fromJson(response.data);
    notifyListeners();
  }

  String getPhotoURL(String schoolNo) {
    if (schoolNo[0] == "1" ||
        schoolNo[0] == "2" ||
        schoolNo[0] == "3" ||
        schoolNo[0] == "4" ||
        schoolNo[0] == "5" ||
        schoolNo[0] == "6" ||
        schoolNo[0] == "7") {
      var data = utf8.encode(schoolNo);
      var digest = md5.convert(data);

      return 'http://bis.ktu.edu.tr/personel/${digest.toString()}.jpg';
    }
    return 'https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png';
  }

  Future<String> signUp(String name, String surname, String fieldOfStudy,
      String email, String password) async {
    Response response;
    var dio = Dio();
    response = await dio.post(
      'http://51.138.78.233/api/auth/register',
      data: {
        'name': name + " " + surname,
        'fieldOfStudy': fieldOfStudy,
        'email': email,
        'password': password,
        'photo_url': getPhotoURL(email.substring(0, 6))
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 201) {
      return "Kayıt Başarılı";
    } else {
      return "Kayıt Başarısız";
    }
  }

  Future<String> changePassword(
      String inputPassword, String newPassword) async {
    Response response;
    IdService id = IdService();
    var dio = Dio();
    response = await dio.put(
      'http://51.138.78.233/api/users/${await id.getId()}/update-password',
      data: {
        'userId': await id.getId(),
        'inputPassword': inputPassword,
        'newPassword': newPassword,
      },
      options: Options(
        headers: {'auth-token': await getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 204) {
      return "Şifre değiştirme başarılı";
    } else {
      return "Şifre değiştirme başarısız";
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', "");
    _isSignedIn = false;
    notifyListeners();
  }

  void setisSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    print(token);
    _isSignedIn = token == "" || token == null ? false : true;
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('auth-token'));
  }
}
