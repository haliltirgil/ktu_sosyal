import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/providers/group_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MembersScreen extends StatefulWidget {
  static const route = '/members';
  final Map<String, String>? map;

  const MembersScreen({Key? key, Map<String, String>? map})
      : map = map,
        super(key: key);
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  void initState() {
    final id = widget.map?['groupId'];
    Provider.of<GroupProvider>(context, listen: false).getGroupMembers(id!);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var groupProvider = Provider.of<GroupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KtuColors.ktuLightBlue,
        // Settings icon
        actions: [
          Container(child: Icon(Icons.person_outline)),
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
      body: groupProvider.isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Text(
                  "Üyeler",
                  style: KtuTextStyles.boldBig,
                ),
                Expanded(child: Members(groupProvider: groupProvider)),
              ],
            ),
    );
  }
}

class Members extends StatelessWidget {
  const Members({
    Key? key,
    required this.groupProvider,
  }) : super(key: key);

  final GroupProvider groupProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            //margin: EdgeInsets.fromLTRB(4.0, 20.0, 16.0, 0.0),
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 12,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              imageUrl: groupProvider.groupMembers[index].photoURL!,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(groupProvider.groupMembers[index].name!),
          subtitle: index == 0 ? Text("Yönetici") : Text("Üye"),
        );
      },
      itemCount: groupProvider.groupMembers.length,
    );
  }
}
