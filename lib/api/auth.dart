import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:workout_app/exceptions/reset_password_needed_exception.dart';
import 'package:workout_app/utils/api_client.dart';

class AuthApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<Map<String, dynamic>> googleLogin(String token) async {
    final response = await http.post(ApiClient.getUri('/login/google/access-token'), body: {
      'token': token,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);

    String jwtToken = data["token"];

    return {"jwtToken": jwtToken};
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(ApiClient.getUri('/login'), body: {
      'email': email,
      'password': password,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);
    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }

    if (data.containsKey('reset') && data['reset'] == 1) {
      throw ResetPasswordNeededException();
    }

    String jwtToken = data["token"];

    return {"jwtToken": jwtToken};
  }

  static Future<http.Response> register(String username, String password, String email) {
    return http.post(ApiClient.getUri('/register'), body: {
      'username': username,
      'password': password,
      'email': email,
    });
  }

  static Future<bool> forgetPassword(String email) async {
    final response = await http.post(ApiClient.getUri('/forget-password'), body: {
      'email': email,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);
    if (response.statusCode != 200) {
      throw Exception({
        "message": data["message"],
        "statusCode": response.statusCode,
      });
    }

    return true;
  }

  static Future<bool> resetPassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    final response =
        await ApiClient().post(ApiClient.getUri('/reset-password'), body: {
      'password': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmNewPassword,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);
    if (response.statusCode != 200) {
      throw Exception({
        "message": data["message"],
        "statusCode": response.statusCode,
      });
    }

    return true;
  }
}