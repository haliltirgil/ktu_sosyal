import 'package:flutter/material.dart';

Container tileButton(BuildContext context, String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    constraints: BoxConstraints(minHeight: 50.0, maxHeight: 95.0),
    margin: EdgeInsets.symmetric(vertical: 2.0),
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: ListTile(
          //trailing: Icon(Icons.home),
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'Rubik',
            ),
          ),
          onTap: () {
            if (text == "Hesap Bilgileri") {
              Navigator.pushNamed(context, '/settingsAccount');
            }
            if (text == "Güvenlik") {
              Navigator.pushNamed(context, '/settingsSecurity');
            }
            if (text == "Tema") {
              Navigator.pushNamed(context, '/settingsTheme');
            }
            if (text == "Hakkında") {
              Navigator.pushNamed(context, '/settingsAbout');
            }
          },
        ),
      ),
    ),
  );
}
