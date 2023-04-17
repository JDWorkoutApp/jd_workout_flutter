import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

  static Future<Map<String, dynamic>> login(String email, String password) async {
    const String path = '/api/login';
    final Uri uri = Uri.parse('$baseAPIUrl$path');

    final response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);
    String jwtToken = data["token"];

    return {"jwtToken": jwtToken};
  }

  static Future<http.Response> register(String username, String password, String email) {
    const String path = '/api/register';

    final Uri uri = Uri.parse('$baseAPIUrl$path');
    return http.post(uri, body: {
      'username': username,
      'password': password,
      'email': email,
    });
  }
}