import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/my_groups_search_list.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SendPostScreen extends StatefulWidget {
  static const route = '/sendPostScreen';

  @override
  _SendPostScreenState createState() => _SendPostScreenState();
}

class _SendPostScreenState extends State<SendPostScreen> {
  final textController = TextEditingController();

  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        actions: [
          Container(
            child: Icon(Icons.send_rounded),
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
      body: Column(
        children: [
          searchBar(),
          Text("Paylaşım göndermek istediğiniz grubu seçiniz."),
          SingleChildScrollView(),
          MyGroupsSearchList(),
        ],
      ),
    );
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.all(10),
        //color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 17),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Arama Yap...',
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                Provider.of<GroupProvider>(context, listen: false)
                    .filterMyGroups(text);
              });
            },
          ),
        ),
      ),
    );
  }
}
