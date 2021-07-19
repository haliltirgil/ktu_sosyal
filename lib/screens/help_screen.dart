import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/help_page_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HelpScreen extends StatefulWidget {
  static const route = '/help';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final textController = TextEditingController();

  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var helpPageProvider = Provider.of<HelpPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        // Settings icon
        actions: [
          Container(
            child: SvgPicture.asset(
              LogoConstants.helpIcon,
              width: 30.0,
              color: KtuColors.ktuWhite,
            ),
          ),
          SizedBox(
            width: 15,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Konu:",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15,
                      ),
                    ),
                    Dropdown(),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 100.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KtuColors.ktuLineColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Lütfen bir şeyler yazınız...",
                    border: InputBorder.none,
                  ),
                  maxLength: 255,
                  maxLines: 6,
                  onChanged: (value) => {helpPageProvider.setText(value)},
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70.0,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () async {
                  var text;
                  if (textController.text == "") {
                    text = "Boş içerik gönderilemez";
                  } else {
                    await helpPageProvider.sendComment();
                    text = "Öneriniz başarıyla oluşturuldu.";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(text),
                      duration: Duration(seconds: 4),
                    ),
                  );
                },
                child: Text(
                  "Gönder",
                  style: TextStyle(
                    color: KtuColors.ktuWhite,
                    fontFamily: 'Rubik',
                  ),
                ),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var helpPageProvider = Provider.of<HelpPageProvider>(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: helpPageProvider.getTopic,
        icon: Icon(Icons.arrow_downward),
        iconSize: 16,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple, fontFamily: 'Rubik'),
        /*underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),*/
        onChanged: (newValue) {
          helpPageProvider.setTopic(newValue!);
          print(helpPageProvider.getTopic);
        },
        items: <String>['Şikayet', 'Öneri']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
