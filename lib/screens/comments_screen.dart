import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/reply_provider.dart';
import 'package:ktu_sosyal/repositories/months_repository.dart';
import 'package:ktu_sosyal/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import '../theme.dart';

class CommentScreen extends StatefulWidget {
  static const route = '/commentScreen';
  final Map<String, String>? map;

  const CommentScreen({Key? key, this.map}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  UserRepository userRepository = UserRepository();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void initState() {
    final postId = widget.map?['postId'];
    final groupId = widget.map?['groupId'];

    var replyProvider = Provider.of<ReplyProvider>(context, listen: false);
    replyProvider.getReplies(groupId!, postId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postId = widget.map?['postId'];
    final groupId = widget.map?['groupId'];
    var authProvider = Provider.of<AuthProvider>(context);
    var replyProvider = Provider.of<ReplyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KtuColors.ktuLightBlue,
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            replyProvider.isLoading == true
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : replyProvider.replies.length == 0
                    ? Expanded(
                        child: Center(
                          child: Text("Yorum yok"),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: replyProvider.replies.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          buildCommenterPhoto(
                                              index, replyProvider),
                                          buildCommenterName(
                                              index, replyProvider),
                                          buildCommentTime(
                                              index, replyProvider),
                                        ],
                                      ),
                                      replyProvider.replies[index].user!.id ==
                                              authProvider.currentUser.id
                                          ? SizedBox(
                                              child: PopupMenuButton(
                                                icon: Icon(Icons
                                                    .more_horiz), //don't specify icon if you want 3 dot menu
                                                itemBuilder: (context) => [
                                                  PopupMenuItem<int>(
                                                    value: 0,
                                                    child: Text(
                                                      "Yorumu sil",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                                onSelected: (item) async => {
                                                  await replyProvider
                                                      .deleteReply(
                                                          groupId!,
                                                          postId!,
                                                          replyProvider
                                                              .replies[index]
                                                              .id!),
                                                  setState(() {
                                                    commentController.text = '';
                                                  })
                                                },
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  buildCommentContent(index, replyProvider),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cevap yaz...',
                hintStyle: KtuTextStyles.light,
                suffixIcon: IconButton(
                    onPressed: () async {
                      var status;
                      if (commentController.text != "") {
                        status = await replyProvider.createReply(
                            groupId!, postId!, commentController.text);
                        setState(() {
                          commentController.text = '';
                        });
                      } else {
                        status = "Boş yorum yapılamaz";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(status),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    icon: Icon(Icons.send)),
              ),
              controller: commentController,
              autofocus: false,
              minLines: 1,
              maxLines: 4,
              keyboardType: TextInputType.text,
            ),
          ],
        ),
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

  Widget buildCommenterPhoto(int index, ReplyProvider replyProvider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
      child: CircleAvatar(
        radius: 20,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          imageUrl: replyProvider.replies[index].user!.photoURL!,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget buildCommenterName(int index, ReplyProvider replyProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text(
        replyProvider.replies[index].user!.name!,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildCommentTime(int index, ReplyProvider replyProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        calculateTime(replyProvider.replies[index].created!),
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget buildCommentContent(int index, ReplyProvider replyProvider) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 8.0),
        child: Text(
          replyProvider.replies[index].content!,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
/*
Future<Column> buildColumn(String groupId, String postId,
    AuthProvider authProvider, BuildContext context) async {
  return Column(
    children: <Widget>[
      Expanded(
        child: FutureBuilder(
          future: replyRepository.getReplies(groupId!, postId!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (replyRepository.replies?.length == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (replyRepository.replies!.length == 0) {
              return Center(
                child: Text("Yorum yok"),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: replyRepository.replies!.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildCommenterPhoto(index),
                              buildCommenterName(index),
                              buildCommentTime(index),
                            ],
                          ),
                          replyRepository.replies![index].user!.id ==
                                  authProvider.currentUser.id
                              ? SizedBox(
                                  child: PopupMenuButton(
                                    icon: Icon(Icons
                                        .more_horiz), //don't specify icon if you want 3 dot menu
                                    itemBuilder: (context) => [
                                      PopupMenuItem<int>(
                                        value: 0,
                                        child: Text(
                                          "Yorumu sil",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                    onSelected: (item) async => {
                                      await replyRepository.deleteReply(
                                          groupId,
                                          postId,
                                          replyRepository.replies![index].id!),
                                      setState(() {
                                        commentController.text = '';
                                      })
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      buildCommentContent(index),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Cevap yaz...',
          hintStyle: KtuTextStyles.light,
          suffixIcon: IconButton(
              onPressed: () async {
                var status;
                if (commentController.text != '') {
                  await replyRepository.createReply(
                              groupId, postId, commentController.text) ==
                          true
                      ? status = "Yorum başarıyla paylaşıldı."
                      : status = "Yorum paylaşılamadı.";

                  setState(() {
                    commentController.text = '';
                  });
                } else {
                  status = "Boş yorum yapılamaz";
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(status),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              icon: Icon(Icons.send)),
        ),
        controller: commentController,
        autofocus: false,
        minLines: 1,
        maxLines: 4,
        keyboardType: TextInputType.text,
      ),
    ],
  );
}
*/
