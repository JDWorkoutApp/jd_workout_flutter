import 'dart:convert';

import 'package:workout_app/utils/api_client.dart';

class AppApi {
  static Future<AppVersion> version() async {
    final response = await ApiClient().get(ApiClient.getUri('/app/version'));

    var body = response.body;
    Map<String, dynamic> data = jsonDecode(body);

    return AppVersion(
        latestVersion: data['latestVersion'],
        requiredVersion: data['requiredVersion']
    );
  }
}

class AppVersion {
  final String latestVersion;
  final String requiredVersion;

  AppVersion({
    required this.latestVersion,
    required this.requiredVersion,
  });
}