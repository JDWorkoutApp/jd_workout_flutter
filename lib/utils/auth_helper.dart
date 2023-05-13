import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static storeLogin(String jwtToken) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', jwtToken);
  }

  static Future<String?> getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');
    return token;
  }
}