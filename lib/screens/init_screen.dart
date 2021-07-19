import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/screens/root.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    onStart();
    super.initState();
  }

  Future<void> onStart() async {
    Provider.of<AuthProvider>(context, listen: false).setisSignedIn();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Root()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
