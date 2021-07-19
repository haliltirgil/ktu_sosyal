import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  static const route = '/message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Row(
        children: [
          Text("Uyudun mu?"),
        ],
      )),
    );
  }
}
