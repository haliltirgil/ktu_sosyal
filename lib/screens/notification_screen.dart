import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/announcement_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/announcement_listview.dart';
import 'package:ktu_sosyal/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const route = "/notification";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Provider.of<AnnouncementProvider>(context, listen: false)
        .getAnnouncements();
    super.initState();
  }

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
      body: AnnouncementListView(),
    );
  }
}
