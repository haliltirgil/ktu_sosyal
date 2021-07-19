import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/group_add_form.dart';
import 'package:ktu_sosyal/widgets/my_groups_listview.dart';
import '../widgets/drawer_widget.dart';

class GroupScreen extends StatefulWidget {
  static const route = '/group';

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: BuildDrawerBar(context),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: SvgPicture.asset(
              LogoConstants.drawerIcon,
              width: 30.0,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: buildToggleButtons(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              child: isSelected[1] ? GroupAddForm() : MyGroupsListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToggleButtons() {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(20.0),
      constraints:
          BoxConstraints(minHeight: 35, maxWidth: 180.0, minWidth: 180),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            'Gruplarım',
            style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: isSelected[1] ? FontWeight.w400 : FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Grup Oluştur',
            style: TextStyle(
                //color: Colors.black,
                fontFamily: 'Rubik',
                fontWeight: isSelected[0] ? FontWeight.w400 : FontWeight.w600),
          ),
        ),
      ],
      onPressed: (int index) {
        setState(() {
          if (index == 0) {
            isSelected[index] = true;
            isSelected[index + 1] = false;
          } else {
            isSelected[index] = true;
            isSelected[index - 1] = false;
          }
        });
      },
      isSelected: isSelected,
    );
  }
}
