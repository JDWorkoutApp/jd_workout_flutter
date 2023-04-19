import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstants {
  static const String apiPrefix = "/api/v1";
  static final String baseURL = dotenv.get('BASE_API_URL');
  static final String apiPath = "$baseURL$apiPrefix";
}