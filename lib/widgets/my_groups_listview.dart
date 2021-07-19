import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/group_model.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class MyGroupsListView extends StatefulWidget {
  @override
  _MyGroupsListViewState createState() => _MyGroupsListViewState();
}

class _MyGroupsListViewState extends State<MyGroupsListView> {
  @override
  void initState() {
    onStart();
    super.initState();
  }

  void onStart() async {
    await Provider.of<GroupProvider>(context, listen: false).setMyGroups();
  }

  @override
  Widget build(BuildContext context) {
    List<Group> myGroups = Provider.of<GroupProvider>(context).myGroups;

    return myGroups.length == 0
        ? Center(
            heightFactor: 20.0,
            child: Container(
              child: Text(
                "Daha hiçbir gruba katılmadın...",
                style: KtuTextStyles.boldBlack,
              ),
            ))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                constraints: BoxConstraints(minHeight: 95.0, maxHeight: 95.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/groupDetail',
                          arguments: <String, String>{
                            'groupId': myGroups[index].id!
                          });
                    },
                    title: Text(myGroups[index].name ?? "",
                        style: KtuTextStyles.regularBlue),
                        //todo backend ayarlanması gerek is admin döndürülmeli
                    //subtitle: Text("${myGroups[index].users?.length}"),
                    //Can delete a group ONLY if they're an admin on the group
                    trailing: isHeAdmin()
                        ? TextButton(
                            child: Icon(Icons.exit_to_app_rounded),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title: Text("Grup silinsin mi?"),
                                  content: Text(
                                      "Not: Tüm gönderiler de silinecektir."),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        "Evet",
                                        style:
                                            TextStyle(color: Colors.red[600]),
                                      ),
                                      onPressed: () async {
                                        String resultString =
                                            await Provider.of<GroupProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteGroupFromDatabase(
                                                    myGroups[index].id);
                                        final snackBar = SnackBar(
                                          content: Text(resultString),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                        child: Text("Hayır"),
                                        onPressed: () =>
                                            {Navigator.pop(context)}),
                                  ],
                                ),
                              );
                            })
                        : null,
                  ),
                ),
              );
            },
            itemCount: myGroups.length,
          );
  }

  bool isHeAdmin() {
    return true;
  }
}
