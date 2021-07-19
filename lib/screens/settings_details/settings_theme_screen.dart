import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/theme_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SettingsThemeScreen extends StatefulWidget {
  static const route = '/settingsTheme';

  @override
  _SettingsThemeScreenState createState() => _SettingsThemeScreenState();
}

class _SettingsThemeScreenState extends State<SettingsThemeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        backgroundColor: KtuColors.ktuLightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 15,
            child: TextButton(
              onPressed: () {
                _themeChanger.setTheme(ThemeData.light());
              },
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Aydınlık Tema")),
            ),
          ),
          Divider(color: KtuColors.ktuDarkBlue),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 15,
            child: TextButton(
              onPressed: () {
                _themeChanger.setTheme(ThemeData.dark());
              },
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Karanlık Tema")),
            ),
          ),
        ],
      ),
    );
  }
}
