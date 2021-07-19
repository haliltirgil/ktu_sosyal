import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).setCurrentUser();
    Provider.of<AuthProvider>(context, listen: false).setHomePagePosts();
    Provider.of<GroupProvider>(context, listen: false).setMyGroups();
    onStart();
    super.initState();
  }

  void onStart() async {}

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      drawer: Drawer(
        child: BuildDrawerBar(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context, rootNavigator: false)
              .pushNamed('/sendPostScreen', arguments: <String, String>{});
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: SvgPicture.asset(
              LogoConstants.drawerIcon,
              width: 30.0,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: authProvider.homePagePosts.length,
            itemBuilder: (context, index) {
              return PostWidget(
                post: authProvider.homePagePosts[index],
                groupId: authProvider.homePagePosts[index].group!.id,
              );
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh() {
    Provider.of<AuthProvider>(context, listen: false).setHomePagePosts();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    return;
  }
}
