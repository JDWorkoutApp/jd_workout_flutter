import 'package:workout_app/api/app_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionChecker {
  static final AppVersionChecker _instance = AppVersionChecker._internal();
  static AppVersionChecker get instance => _instance;

  String _currentVersion = '';
  bool _checked = false;

  AppVersionChecker._internal();

  Future<void> checkAppVersion() async {
    print("call checkAppVersion");
    if (_checked) return;

    print("checkAppVersion start checking");

    _checked = true;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print('version: $version, buildNumber: $buildNumber');
      AppApi.version().then((AppVersion appVersion) {
        print('back end appVersion: ${appVersion.latestVersion}, ${appVersion.requiredVersion}');
      });
    });
  }

  String getCurrentVersion() {
    return _currentVersion;
  }
}