import 'package:flutter/cupertino.dart';
import 'package:ktu_sosyal/models/request/post_model.dart';
import 'package:ktu_sosyal/repositories/post_repository.dart';

class PostProvider with ChangeNotifier {
  PostRepository _postRepository = PostRepository();

  Future<String> createGroupPost(String content, String groupId) async {
    PostRequest pr = PostRequest(content);
    final resultString = await _postRepository.createGroupPost(pr, groupId);
    return resultString;
  }

  Future<String> createUserPost(String content) async {
    PostRequest pr = PostRequest(content);
    final resultString = await _postRepository.createUserPost(pr);
    return resultString;
  }
}
