import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/post_model.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/theme_provider.dart';
import 'package:ktu_sosyal/repositories/post_repository.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';
import '../repositories/months_repository.dart';
import '../theme.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final groupId;
  const PostWidget({Key? key, required this.post, this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var themeProvider = Provider.of<ThemeChanger>(context, listen: false);

    PostRepository postRepository = PostRepository();
    return Container(
      margin: EdgeInsets.fromLTRB(4, 6, 4, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 2, color: KtuColors.ktuLineColor),
      ),
      padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0.0, 8.0, 0.0),
                  width: 50,
                  height: 50,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    imageUrl: post.user!.photoURL!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  post.user!.name!,
                                  style: themeProvider.getTheme() ==
                                          ThemeData.light()
                                      ? KtuTextStyles.boldBlack
                                      : KtuTextStyles.boldWhite,
                                ),
                                onPressed: () => {
                                  Navigator.pushNamed(context, '/profile',
                                      arguments: <String, String>{
                                        'userId': post.user!.id!,
                                      })
                                },
                              ),
                              SizedBox(
                                width: 30,
                                child: Icon(Icons.arrow_right_rounded),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/groupDetail',
                                      arguments: <String, String>{
                                        'groupId': post.group!.id!,
                                      });
                                },
                                child: Text(
                                  post.group!.name!,
                                  style: themeProvider.getTheme() ==
                                          ThemeData.light()
                                      ? KtuTextStyles.boldBlack
                                      : KtuTextStyles.boldWhite,
                                ),
                              )
                            ],
                          ),
                          if (post.user!.name == authProvider.currentUser.name)
                            PopupMenuButton(
                              icon: Icon(Icons.more_horiz),
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text(
                                    "Gönderiyi sil",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                              onSelected: (item) => {
                                postRepository.deletePost(post.id!, context)
                              },
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(calculateTime(post.created!),
                            style: KtuTextStyles.regular),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 20,
                color: KtuColors.ktuDarkBlue,
              ),
              Text(
                post.content!,
                style: KtuTextStyles.regular,
              ),
              SizedBox(
                height: 10,
              ),
              post.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl!,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Container()
            ],
          ),
          TextButton(
            child: post.replies!.length == 0
                ? Text("Yorum yok")
                : Text(("${post.replies!.length} yorum var")),
            onPressed: () => {
              Navigator.of(context, rootNavigator: false).pushNamed(
                '/commentScreen',
                arguments: <String, String>{
                  'postId': post.id!,
                  'groupId': groupId!,
                },
              )
            },
          ),
        ],
      ),
    );
  }

  calculateTime(String time) {
    DateTime postTime = DateTime.parse(time).toLocal();
    String minute = postTime.minute.toString();
    if (postTime.minute < 10) {
      minute = '0${postTime.minute}';
    }
    if (postTime.year != DateTime.now().year) {
      return ("${postTime.day} ${getMonth(postTime.month)} ${postTime.year}");
    } else if (postTime.day != DateTime.now().day) {
      return ("${postTime.day} ${getMonth(postTime.month)} ${postTime.hour}:$minute");
    }
    return ("Bugün ${postTime.hour}:$minute");
  }
}
