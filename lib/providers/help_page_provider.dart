import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ktu_sosyal/services/token_service.dart';

class HelpPageProvider extends ChangeNotifier {
  var dio = Dio();
  String topic = "Şikayet";
  String text = '';

  String get getTopic => topic;
  String get getText => text;

  setTopic(String topic) {
    this.topic = topic;
    notifyListeners();
  }

  setText(String text) => {this.text = text};

  sendComment() async {
    TokenService token = TokenService();

    await dio.post(
      'http://51.138.78.233/api/helps',
      data: {'content': topic, 'text': text},
      options: Options(
        headers: {'auth-token': await token.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
