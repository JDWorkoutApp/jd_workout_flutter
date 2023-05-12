import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static storeLogin(String jwtToken) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', jwtToken);
  }
}