import 'package:flutter/material.dart';
import 'package:ktu_sosyal/theme.dart';

class NotificationListView extends StatefulWidget {
  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  @override
  Widget build(BuildContext context) {
    final int number = 1; //  gösterilecek sayfayı buradan ayarla

    return number == 0
        ? Center(
            heightFactor: 20.0,
            child: Container(
              child: Text(
                "Yeni bir bildirim yok...",
                style: KtuTextStyles.boldBlack,
              ),
            ))
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                constraints: BoxConstraints(minHeight: 50.0, maxHeight: 95.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text("Gruptan 2 yeni bildirim",
                        style: KtuTextStyles.regularBlue),
                    leading: TextButton(
                        child: Icon(Icons.notifications),
                        onPressed: () async {}),
                  ),
                ),
              );
            },
            itemCount: 6,
          );
  }
}
