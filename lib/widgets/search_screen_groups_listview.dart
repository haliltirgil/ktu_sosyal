import 'package:flutter/material.dart';
import 'package:ktu_sosyal/models/group_model.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SearchScreenGroups extends StatefulWidget {
  @override
  _SearchScreenGroupsState createState() => _SearchScreenGroupsState();
}

class _SearchScreenGroupsState extends State<SearchScreenGroups> {
  @override
  void initState() {
    onStart();
    super.initState();
  }

  void onStart() async {
    Provider.of<GroupProvider>(context, listen: false).getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    List<Group> allGroupsSearch =
        Provider.of<GroupProvider>(context).allGroupsSearch;

    return allGroupsSearch.length == 0
        ? Center(
            heightFactor: 20.0,
            child: Container(
              child: Text(
                "Hicbir Grup Bulunamadi",
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
                            'groupId': allGroupsSearch[index].id!
                          }).then((_) => setState(() {}));
                    },
                    title: Text(allGroupsSearch[index].name ?? "",
                        style: KtuTextStyles.regularBlue),
                    subtitle: Text(
                        "${allGroupsSearch[index].users?.length} Üye(ler)"),
                  ),
                ),
              );
            },
            itemCount: allGroupsSearch.length,
          );
  }
}
