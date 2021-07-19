import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/announcement_provider.dart';
import 'package:ktu_sosyal/providers/theme_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementListView extends StatefulWidget {
  @override
  _AnnouncementListViewState createState() => _AnnouncementListViewState();
}

class _AnnouncementListViewState extends State<AnnouncementListView> {
  @override
  Widget build(BuildContext context) {
    var announcementProvider = Provider.of<AnnouncementProvider>(context);
    var themeProvider = Provider.of<ThemeChanger>(context, listen: false);

    return announcementProvider.announcements.length == 0
        ? Center(
            heightFactor: 20.0,
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                // constraints: BoxConstraints(minHeight: 50.0, maxHeight: 95.0),
                child: Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    onTap: () async {
                      if (await canLaunch(
                          announcementProvider.announcements[index].link!))
                        await launch(
                            announcementProvider.announcements[index].link!);
                    },
                    title: Text(
                      "${announcementProvider.announcements[index].title}",
                      style: themeProvider.getTheme() == ThemeData.light()
                          ? KtuTextStyles.regularBlue
                          : KtuTextStyles.boldWhite,
                    ),
                    leading: Icon(
                      Icons.announcement,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
            itemCount: announcementProvider.announcements.length,
          );
  }
}
