import 'package:flutter/cupertino.dart';
import 'package:ktu_sosyal/models/reply_model.dart';
import 'package:ktu_sosyal/models/request/reply_model.dart';
import 'package:ktu_sosyal/repositories/reply_repository.dart';
import 'package:ktu_sosyal/services/id_service.dart';

class ReplyProvider with ChangeNotifier {
  List<Reply> _replies = [];
  bool? _isLoading;
  ReplyRepository replyRepository = ReplyRepository();

  List<Reply> get replies => _replies;
  bool? get isLoading => _isLoading;

  Future<String> createReply(
      String groupId, String postId, String content) async {
    IdService id = IdService();

    ReplyRequest rr = ReplyRequest(content, await id.getId());
    final resultString = await replyRepository.createReply(rr, groupId, postId);
    getReplies(groupId, postId);
    return resultString;
  }

  Future<void> getReplies(String groupId, String postId) async {
    _isLoading = true;
    //notifyListeners();
    //todo eklersek setState  sürekli çağrılıyor hatası veriyor.
    ReplyRepository replyRepository = ReplyRepository();
    _replies = await replyRepository.getReplies(groupId, postId);
    _isLoading = false;
    notifyListeners();
  }

  Future<String> deleteReply(
      String groupId, String postId, String replyId) async {
    ReplyRepository replyRepository = ReplyRepository();
    final resultString =
        await replyRepository.deleteReply(groupId, postId, replyId);
    getReplies(groupId, postId);
    return resultString;
  }
}
