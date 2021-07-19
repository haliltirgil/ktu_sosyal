import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SettingsSecurityScreen extends StatefulWidget {
  static const route = '/settingsSecurity';

  @override
  _SettingsSecurityScreenState createState() => _SettingsSecurityScreenState();
}

class _SettingsSecurityScreenState extends State<SettingsSecurityScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordRepeatController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        backgroundColor: KtuColors.ktuLightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTextForm("Mevcut Şifre", _currentPasswordController),
              SizedBox(height: MediaQuery.of(context).size.height / 70),
              _buildTextForm("Yeni Şifre", _newPasswordController),
              SizedBox(height: MediaQuery.of(context).size.height / 70),
              _buildTextForm("Yeni Şifre Tekrar", _newPasswordRepeatController),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextForm(String text, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          const Radius.circular(18.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 15),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: text,
          labelStyle: KtuTextStyles.regular,
          //errorText: signInValidatonProvider.fieldOfStudy.error,
        ),
        controller: controller,
      ),
    );
  }

  _buildUpdateButton() {
    var authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.7,
      height: MediaQuery.of(context).size.height / 20,
      child: TextButton(
        onPressed: () async {
          if (_newPasswordController.text ==
              _newPasswordRepeatController.text) {
            var text = await authProvider.changePassword(
                _currentPasswordController.text, _newPasswordController.text);
            final snackBar = SnackBar(
              content: Text(text),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              content: Text("Yeni şifreler eşleşmiyor. Tekrar deneyiniz."),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Text(
          "Güncelle",
          style: TextStyle(
            color: KtuColors.ktuWhite,
            fontFamily: 'Rubik',
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green[700]!)),
      ),
    );
  }
}
