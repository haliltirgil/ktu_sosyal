import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/search_screen_groups_listview.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widgets/drawer_widget.dart';

class SearchScreen extends StatefulWidget {
  static const route = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: BuildDrawerBar(context),
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
          child: Column(
            children: [
              searchBar(),
              SearchScreenGroups(),
            ],
          ),
        ),
      ),
    );
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.all(10),
        //color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 17),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Arama Yap...',
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                Provider.of<GroupProvider>(context, listen: false)
                    .filterGroups(text);
              });
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh() {
    Provider.of<GroupProvider>(context, listen: false).getAllGroups();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() {}

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
