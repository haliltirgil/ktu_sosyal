import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/buttons.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  static const route = '/settings';
  List<String> buttons = ["Hesap Bilgileri", "Güvenlik", "Tema", "Hakkında"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        // Settings icon
        actions: [
          Container(
            child: SvgPicture.asset(
              LogoConstants.settingsIcon,
              width: 30.0,
              color: KtuColors.ktuWhite,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height / 50.0,
          ),
        ],
        // BackButton
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 32,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
      ),
      // Buttons
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: ListView.builder(
          itemCount: buttons.length,
          itemBuilder: (BuildContext context, int index) {
            return tileButton(context, buttons[index]);
          },
        ),
      ),
    );
  }
}
