import 'package:workout_app/utils/auth_helper.dart';

import '../constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  final http.Client _inner = http.Client();

    static Uri getUri(String path) {
        return Uri.parse('${APIConstants.apiPath}$path');
    }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? jwtToken = await AuthHelper.getJwtToken();
    request.headers['Authorization'] = 'Bearer $jwtToken';
    return _inner.send(request);
  }
}