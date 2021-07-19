import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/faculty_provider.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/widgets/not_found.dart';
import 'package:ktu_sosyal/widgets/post_widget.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupDetailScreen extends StatefulWidget {
  static const route = '/groupDetail';
  final Map<String, String>? map;

  const GroupDetailScreen({Key? key, Map<String, String>? map})
      : map = map,
        super(key: key);
  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  bool isJoined = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    final groupId = widget.map?['groupId'];
    Provider.of<GroupProvider>(context, listen: false).getOneGroup(groupId!);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupId = widget.map?['groupId'];
    var groupProvider = Provider.of<GroupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KtuColors.ktuLightBlue,
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 32,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context, rootNavigator: false)
              .pushNamed('/postScreen', arguments: <String, String>{
            'groupId': groupId!,
          });
        },
      ),
      body: groupProvider.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : groupProvider.isDeleted == true
              ? NotFoundException()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildGroupDetail(context, groupId!),
                      Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: groupProvider.group!.posts!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  PostWidget(
                                      post: groupProvider.group!.posts![index],
                                      groupId: groupId),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  FutureBuilder<dynamic> buildFutureBuilder(
      GroupProvider groupProvider, String groupId) {
    return FutureBuilder<dynamic>(
      future: groupProvider.getOneGroup(groupId),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data == false) {
            return NotFoundException();
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildGroupDetail(context, groupId),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.posts?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PostWidget(
                                post: snapshot.data!.posts![index],
                                groupId: groupId),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Container buildGroupDetail(BuildContext context, String groupId) {
    var groupProvider = Provider.of<GroupProvider>(context);
    var facultyProvider = Provider.of<FacultyProvider>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: KtuColors.ktuLineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupProvider.group!.name!,
            style: KtuTextStyles.boldBig,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 150),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                facultyProvider.defaultFaculty,
                style: KtuTextStyles.bold,
              ),
              TextButton(
                onPressed: () => {
                  Navigator.of(context).pushNamed(
                    '/members',
                    arguments: <String, String>{
                      'groupId': groupProvider.group!.id!,
                    },
                  ),
                },
                child: Text(
                    '${groupProvider.group!.users!.length.toString()} Üye',
                    style: KtuTextStyles.regularBlack),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 5,
                child: groupProvider.isJoined == true
                    ? TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Text(
                                  "Gruptan ayrılmak istediğinize emin misiniz?"),
                              content: Text(
                                  "Eğer ayrılırsanız gönderileri görmeniz için tekrardan gruba katılmanız gerekecek."),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text(
                                      "Evet",
                                      style: TextStyle(color: Colors.red[600]),
                                    ),
                                    onPressed: () async {
                                      await groupProvider.leaveGroup(groupId);

                                      Navigator.pop(context);
                                    }),
                                CupertinoDialogAction(
                                    child: Text("Hayır"),
                                    onPressed: () => {Navigator.pop(context)}),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Ayrıl",
                          style: TextStyle(color: KtuColors.ktuWhite),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red[600]!)),
                      )
                    : TextButton(
                        onPressed: () async {
                          bool status = await groupProvider.joinGroup(groupId);
                        },
                        child: Text(
                          "Katıl",
                          style: TextStyle(color: KtuColors.ktuWhite),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[600]!)),
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onRefresh() {
    //Provider.of<AuthProvider>(context, listen: false).setHomePagePosts();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() {}
}
