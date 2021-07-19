import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
    Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('auth-token'));
  }
}