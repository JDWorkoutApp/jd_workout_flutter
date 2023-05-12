import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class AuthApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<Map<String, dynamic>> GooglLogin(String token) async {
    final Uri uri = Uri.parse('${APIConstants.apiPath}/login/google/access-token');
    final response = await http.post(uri, body: {
      'token': token,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);

    String jwtToken = data["token"];

    return {"jwtToken": jwtToken};
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri uri = Uri.parse('${APIConstants.apiPath}/login');

    final response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);
    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }

    String jwtToken = data["token"];

    return {"jwtToken": jwtToken};
  }

  static Future<http.Response> register(String username, String password, String email) {
    final Uri uri = Uri.parse('${APIConstants.apiPath}/register');
    return http.post(uri, body: {
      'username': username,
      'password': password,
      'email': email,
    });
  }
}