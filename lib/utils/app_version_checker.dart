import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workout_app/api/app_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionChecker {
  static final AppVersionChecker _instance = AppVersionChecker._internal();

  static AppVersionChecker get instance => _instance;

  bool _checked = false;

  AppVersionChecker._internal();

  Future<void> checkAppVersion(BuildContext context) async {
    if (_checked) return;

    List<dynamic> result = await Future.wait([
      PackageInfo.fromPlatform(),
      AppApi.version(),
    ]);

    _checked = true;
    PackageInfo packageInfo = result[0];
    AppVersion appVersion = result[1];
    String currentVersion = packageInfo.version;
    String latestVersion = appVersion.latestVersion;
    String requiredVersion = appVersion.requiredVersion;

    if (requiredVersion.compareTo(currentVersion) > 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('App強制更新'),
            content: Text('您需要更新App版本以繼續使用'),
            actions: [
              TextButton(
                child: Text('前往更新'),
                onPressed: () {
                  launchAppStore();
                },
              ),
            ],
          );
        },
      );

      return;
    }
  }

  launchAppStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=your_app_package_id';

    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
