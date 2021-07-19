import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SettingsAccountScreen extends StatefulWidget {
  static const route = '/settingsAccount';

  @override
  _SettingsAccountScreenState createState() => _SettingsAccountScreenState();
}

class _SettingsAccountScreenState extends State<SettingsAccountScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        backgroundColor: KtuColors.ktuLightBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // değişebilir

          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 200),
            Text(
              "Kullanıcı Adı",
              style: _headerStyle(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 200),
            Text(
              authProvider.currentUser.name!,
              style: _bodyStyle(),
            ),
            Divider(color: KtuColors.ktuDarkBlue),
            Text(
              "Okul Numarası",
              style: _headerStyle(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 200),
            Text(
              authProvider.currentUser.email!,
              style: _bodyStyle(),
            ),
            Divider(color: KtuColors.ktuDarkBlue),
            Text(
              "Bölümü",
              style: _headerStyle(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 200),
            Text(
              "Bilgisayar Mühendisliği",
              style: _bodyStyle(),
            ),
            Divider(color: KtuColors.ktuDarkBlue),
            TextButton(
              onPressed: () async {
                authProvider.logOut();
              },
              child: Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: Colors.red[700],
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(color: KtuColors.ktuDarkBlue),
          ],
        ),
      ),
    );
  }

  _headerStyle() {
    return TextStyle(
      fontFamily: 'Rubik',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  _bodyStyle() {
    return TextStyle(
      color: Colors.grey,
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }
}
