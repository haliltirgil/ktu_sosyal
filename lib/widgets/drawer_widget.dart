import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class BuildDrawerBar extends StatelessWidget {
  BuildDrawerBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var _lineColor = Colors.grey.shade400;
    var drawerHeader = DrawerHeader(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(4.0, 20.0, 16.0, 0.0),
                  width: MediaQuery.of(context).size.width / 7,
                  height: MediaQuery.of(context).size.height / 12,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    imageUrl: authProvider.currentUser.photoURL!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 50.0, 0.0, 8.0),
                  child: Text(
                    authProvider.currentUser.name!,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Bulunduğum Topluluk Sayısı : ${authProvider.currentUser.groups!.length}",
                    style: TextStyle(fontSize: 13.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    return ListView(
      children: <Widget>[
        drawerHeader,
        Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: _lineColor))),
          child: ListTile(
            leading: SvgPicture.asset(
              LogoConstants.profileIcon2,
              width: 27.0,
            ),
            title: Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile',
                  arguments: <String, String>{
                    'userId': authProvider.currentUser.id!
                  });
            },
          ),
        ),
        /* Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: _lineColor))),
          child: ListTile(
            leading: SvgPicture.asset(
              LogoConstants.notificationIcon,
              width: 27.0,
            ),
            title: Text('Duyurular'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, "/notification");
            },
          ),
        ), */
        Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: _lineColor))),
          child: ListTile(
            leading: SvgPicture.asset(
              LogoConstants.communityIcon,
              width: 27.0,
            ),
            title: Text('Topluluklar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, "/group");
            },
          ),
        ),
        Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: _lineColor))),
          child: ListTile(
            leading: SvgPicture.asset(
              LogoConstants.settingsIcon,
              width: 27.0,
            ),
            title: Text('Ayarlar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ),
        Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: _lineColor))),
          child: ListTile(
            leading: SvgPicture.asset(
              LogoConstants.helpIcon,
              width: 27.0,
            ),
            title: Text('Yardım ve Öneri'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
        ),
        Consumer<AuthProvider>(builder: (context, authProvider, _) {
          return Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: _lineColor))),
            child: ListTile(
              leading: SvgPicture.asset(
                LogoConstants.logoutIcon,
                width: 29.0,
              ),
              title: Text('Çıkış'),
              onTap: () async {
                authProvider.logOut();
              },
            ),
          );
        }),
      ],
    );
  }
}
