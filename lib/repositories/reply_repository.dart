import 'package:dio/dio.dart';
import 'package:ktu_sosyal/models/reply_model.dart';
import 'package:ktu_sosyal/models/request/reply_model.dart';
import 'package:ktu_sosyal/repositories/user_repository.dart';
import 'package:ktu_sosyal/services/id_service.dart';
import 'package:ktu_sosyal/services/token_service.dart';

class ReplyRepository {
  Dio dio = Dio();
  TokenService tokenService = TokenService();

  Future<List<Reply>> getReplies(String groupId, String postId) async {
    List<Reply> replies = [];
    Response response;
    UserRepository userRepository = UserRepository();
    response = await dio.get(
      'http://51.138.78.233/api/groups/$groupId/posts/$postId/replies',
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> reply in response.data) {
        replies.add(Reply(reply["id"], reply["content"], reply["created"],
            await userRepository.getUser(reply["user_Id"]!)));
      }
    }
    return replies;
  }

  Future<String> createReply(
      ReplyRequest rr, String groupId, String postId) async {
    Response response;
    print(
      'http://51.138.78.233/api/groups/$groupId/posts/$postId/replies',
    );
    response = await dio.post(
      'http://51.138.78.233/api/groups/$groupId/posts/$postId/replies',
      data: rr.toJson(),
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );

    if (response.statusCode == 200) {
      return "Yorum başarıyla paylaşıldı.";
    }
    return "Yorum oluşturulamadı";
  }

  Future<String> deleteReply(
      String groupId, String postId, String replyId) async {
    Response response;
    IdService id = IdService();
    response = await dio.delete(
      'http://51.138.78.233/api/users/${await id.getId()}/posts/$postId/replies/$replyId',
      data: {'replyId': replyId},
      options: Options(
        headers: {'auth-token': await tokenService.getToken()},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );

    if (response.statusCode == 200) {
      return "Yorum başarıyla silindi.";
    }
    return "Yorum silinemedi";
  }
}
