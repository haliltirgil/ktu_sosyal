import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktu_sosyal/providers/post_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  static const route = '/postScreen';
  final Map<String, String>? map;

  const PostScreen({Key? key, this.map}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController textEditingController = TextEditingController();
  late File _image;
  final picker = ImagePicker();
  bool isSelected = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final groupId = widget.map?['groupId'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KtuColors.ktuLightBlue,
        title: SvgPicture.asset(LogoConstants.appBarLogo, width: 30.0),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 2, color: KtuColors.ktuLineColor),
                ),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Ne düşünüyorsun?',
                  ),
                  controller: textEditingController,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Center(
                child: isSelected == true ? Image.file(_image) : null,
              ),
              isSelected
                  ? SizedBox(
                      height: 40,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "Foto sil",
                          style: TextStyle(color: KtuColors.ktuWhite),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            isSelected = false;
                          });
                        },
                      ),
                    )
                  : SizedBox(
                      height: 40,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "Fotoğraf ekle",
                          style: TextStyle(color: KtuColors.ktuWhite),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green,
                          ),
                        ),
                        onPressed: () async {
                          isSelected = await getImage();
                        },
                      ),
                    ),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 100,
                child: TextButton(
                  child: Text(
                    "Paylaş",
                    style: TextStyle(color: KtuColors.ktuWhite),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        KtuColors.ktuLightBlue),
                  ),
                  onPressed: () async {
                    final String resultString = groupId != null
                        ? await postProvider.createGroupPost(
                            textEditingController.text, groupId)
                        : await postProvider
                            .createUserPost(textEditingController.text);
                    final snackBar = SnackBar(
                      content: Text(resultString),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      return true;
    } else {
      print('No image selected.');
      return false;
    }
  }
}
