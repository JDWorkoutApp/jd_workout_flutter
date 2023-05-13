import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:workout_app/utils/api_client.dart';

import '../constants/api_constants.dart';

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
}