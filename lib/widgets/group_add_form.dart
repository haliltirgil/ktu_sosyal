import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/faculty_provider.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class GroupAddForm extends StatefulWidget {
  @override
  _GroupAddFormState createState() => _GroupAddFormState();
}

class _GroupAddFormState extends State<GroupAddForm> {
  TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var groupProvider = GroupProvider();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 60.0, maxHeight: 60.0),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 15),
          child: TextFormField(
              style: KtuTextStyles.regular,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(18.0),
                  ),
                ),
                hintText: "Grup Adı",
                labelStyle: KtuTextStyles.regular,
              ),
              controller: _groupNameController),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 25),
        Padding(
          padding: const EdgeInsets.only(left: 34.0),
          child: Text(
            "Fakülte Belirtiniz:",
            style: TextStyle(
              fontFamily: 'Rubik',
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 85),
        //fakulte belirtme alanı
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(18.0),
                ),
              ),
              constraints: BoxConstraints(minHeight: 60.0, maxHeight: 60.0),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 25),
              width: MediaQuery.of(context).size.width / 1.15,
              child: Dropdown(),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 12),
        buildCreateButton(context, groupProvider, authProvider),
      ],
    );
  }

  Widget buildCreateButton(BuildContext context, GroupProvider groupProvider,
      AuthProvider authProvider) {
    var facultyProvider = Provider.of<FacultyProvider>(context);
    return Align(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: KtuColors.ktuLightBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ],
        ),
        // ignore: deprecated_member_use
        child: OutlineButton(
          highlightedBorderColor: KtuColors.ktuLightBlue,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: Text(
            'Oluştur',
            style: KtuTextStyles.regularWhite,
          ),
          onPressed: () async {
            if (_groupNameController.text == "") {
              final snackBar = SnackBar(
                content: Text("Grup İsmi Giriniz"),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              print(prefs.getString('auth-token'));
              String createGroup = await groupProvider.createGroup(
                  _groupNameController.text, facultyProvider.defaultFaculty);
              final snackBar = SnackBar(
                content: Text(createGroup),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var facultyProvider = Provider.of<FacultyProvider>(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: facultyProvider.getDefaultFaculty,
        onChanged: (newValue) {
          facultyProvider.setDefaultFaculty(newValue!);
          print(facultyProvider.getDefaultFaculty);
        },
        items: <String>[
          'Diş Hekimliği Fakültesi',
          'Eczacılık Fakültesi',
          'Edebiyat Fakültesi',
          'Fen Fakültesi',
          'Iktisat Fakültesi',
          'Mimarlık Fakültesi',
          'Mühendislik Fakültesi',
          'Teknoloji Fakültesi',
          'Orman Fakültesi',
          'Sağlık Bilimleri Fakültesi',
          'Deniz Bilimleri Fakültesi',
          'Tıp Fakültesi'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
