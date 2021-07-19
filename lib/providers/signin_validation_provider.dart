import 'package:flutter/foundation.dart';
import 'package:ktu_sosyal/models/form_validation_model.dart';

class SignInValidation with ChangeNotifier {
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _surname = ValidationItem(null, null);
  ValidationItem _fieldOfStudy = ValidationItem(null, null);
  String _emailType = '@ogr.ktu.edu.tr';
  bool _toggleLoginLogout = false;

  ValidationItem get email => _email;
  ValidationItem get password => _password;
  String get emailtype => _emailType;
  bool get toggleLoginLogout => _toggleLoginLogout;
  ValidationItem get name => _name;
  ValidationItem get surname => _surname;
  ValidationItem get fieldOfStudy => _fieldOfStudy;

  void setEmail(String value) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value) &&
            value.endsWith('@ogr.ktu.edu.tr') ||
        value.endsWith('@ktu.edu.tr')) {
      _email = ValidationItem(value, null);
    } else {
      _email = ValidationItem(null, 'e-mail geçersiz');
    }
    notifyListeners();
  }

  void setName(String value) {
    if (RegExp(r'^[a-zA-Z]+(\s[a-zA-Z]+)?$').hasMatch(value)) {
      _name = ValidationItem(value, null);
    } else {
      _name = ValidationItem(null, 'İsimde sadece karakter olabilir');
    }
    notifyListeners();
  }

  void setSurname(String value) {
    if (RegExp(r'^[A-Za-z-ğüşöçİĞÜŞÖÇ]+$').hasMatch(value)) {
      _surname = ValidationItem(value, null);
    } else {
      _surname = ValidationItem(null, 'Soyadında sadece karakter olabilir');
    }
    notifyListeners();
  }

  void setFieldOfStudy(String value) {
    if (value.length > 5) {
      _fieldOfStudy = ValidationItem(value, null);
    } else {
      _fieldOfStudy =
          ValidationItem(null, 'Bölüm 5 karakterden fazla olmalıdır.');
    }
    notifyListeners();
  }

  void setEmailType(int index) {
    index == 1 ? _emailType = '@ktu.edu.tr' : _emailType = '@ogr.ktu.edu.tr';
    notifyListeners();
  }

  void setPassword(String value) {
    if (value.length < 6) {
      _password =
          ValidationItem(null, 'Şifre 6 karakterden fazla olması lazım.');
    } else {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setToggleLoginLogout() {
    // To reset the fields when toggling
    _email = ValidationItem(null, null);
    _password = ValidationItem(null, null);
    _name = ValidationItem(null, null);
    _surname = ValidationItem(null, null);
    _fieldOfStudy = ValidationItem(null, null);

    _toggleLoginLogout = !_toggleLoginLogout;
    notifyListeners();
  }
}
