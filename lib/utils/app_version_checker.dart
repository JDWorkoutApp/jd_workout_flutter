import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workout_app/api/app_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionChecker {
  static final AppVersionChecker _instance = AppVersionChecker._internal();

  static AppVersionChecker get instance => _instance;

  bool _checked = false;

  AppVersionChecker._internal();

  Future<void> checkAppVersion(BuildContext context) async {
    if (dotenv.get('SKIP_APP_VERSION_CHECK') == 'true') {
      return;
    }

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

    if (context.mounted) {
      if (requiredVersion.compareTo(currentVersion) > 0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('App強制更新'),
              content: const Text('您需要更新App版本以繼續使用'),
              actions: [
                TextButton(
                  child: const Text('前往更新'),
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

      if (latestVersion.compareTo(currentVersion) > 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('可更新版本'),
              content: const Text('有新版本可供更新'),
              actions: [
                TextButton(
                  child: Text('更新'),
                  onPressed: () {
                    launchAppStore();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  launchAppStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.govel.workout';

    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
