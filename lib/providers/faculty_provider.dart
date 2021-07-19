import 'package:flutter/material.dart';

class FacultyProvider extends ChangeNotifier {
  String defaultFaculty = "Diş Hekimliği Fakültesi";

  String get getDefaultFaculty => defaultFaculty;

  setDefaultFaculty(String defaultFaculty) {
    this.defaultFaculty = defaultFaculty;
    notifyListeners();
  }
}
