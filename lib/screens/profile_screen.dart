import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/repositories/user_repository.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:ktu_sosyal/widgets/post_widget.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/profile';
  final Map<String, String>? map;

  const ProfileScreen({Key? key, this.map}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).setMyPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    final userId = widget.map!['userId'];
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
        backgroundColor: KtuColors.ktuLightBlue,
      ),
      body: FutureBuilder(
        future: userRepository.getUser(userId!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print("if");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print("else");
            print(snapshot.data.name);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildProfilePhoto(context, snapshot.data.photoURL),
                  buildProfileInformation(context, snapshot.data.name),
                  Divider(
                    color: KtuColors.ktuLineColor,
                  ),
                  SingleChildScrollView(
                    child: userRepository.posts.length == 0
                        ? Center(
                            child: Text("Herhangi bir gönderi bulunamadı"),
                          )
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: userRepository.posts.length,
                            itemBuilder: (context, index) {
                              return PostWidget(
                                  post: userRepository.posts[index],
                                  groupId:
                                      userRepository.posts[index].group!.id);
                            },
                          ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget buildProfilePhoto(BuildContext context, String photoURL) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Center(
      child: CircleAvatar(
        radius: 50,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          imageUrl: photoURL,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
  );
}

Widget buildProfileInformation(BuildContext context, String name) {
  var authProvider = Provider.of<AuthProvider>(context);
  return Column(
    children: [
      Text(
        name,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height / 80),
      Text(
        "Bölümü: " + authProvider.currentUser.fieldOfStudy!,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height / 80),
      //buildButton(),
    ],
  );
}

Widget buildButton() {
  return OutlinedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(KtuColors.ktuLightBlue),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
    ),
    child: Text(
      "Düzenle",
      style: TextStyle(
        color: KtuColors.ktuWhite,
        fontFamily: 'Rubik',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
