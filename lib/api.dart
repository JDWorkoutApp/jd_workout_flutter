import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Api {
  static final String? baseAPIUrl = dotenv.env['BASE_API_URL'];

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