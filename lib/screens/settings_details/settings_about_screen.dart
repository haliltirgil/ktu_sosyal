import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/theme.dart';

class SettingsAboutScreen extends StatefulWidget {
  static const route = '/settingsAbout';

  @override
  _SettingsAboutScreenState createState() => _SettingsAboutScreenState();
}

class _SettingsAboutScreenState extends State<SettingsAboutScreen> {
  @override
  Widget build(BuildContext context) {
    String _text =
        "KTU SOSYAL\n\nBu uygulama Karadeniz Teknik Üniversitesi öğrencileri tarafından Bitirme Projesi olarak geliştirilmiştir. \n\nAmacı Karadeniz Teknik Üniversitesi öğrencileri ortak bir portalda birleştirip üniversite içinde öğrenci-öğrenci ya da öğrenci-akademisyen iletişimini daha sağlıklı ve canlı bir hale getirmektir.\n\n\nGeliştiriciler:\n\nSercan TOR\n\nİlyas AKTURAN\n\nHalil İbrahim TİRGİL";
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        backgroundColor: KtuColors.ktuLightBlue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width / 50.0),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: KtuColors.ktuLineColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              _text,
              style: TextStyle(fontFamily: 'Rubik'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 42.0),
            _buildKtuLogo(),
          ],
        ),
      ),
    );
  }

  Widget _buildKtuLogo() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
      child: Align(
        child: SvgPicture.asset(
          LogoConstants.ktuLogo,
          height: MediaQuery.of(context).size.height / 5,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
