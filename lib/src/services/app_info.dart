import 'package:package_info_plus/package_info_plus.dart';

/// App info model
class VizzhyAppInfoModel {
  /// costructor
  VizzhyAppInfoModel(
      this.appName, this.packageName, this.version, this.buildNumber);

  /// app name
  final String appName;

  /// app package name
  final String packageName;

  /// app version
  final String version;

  /// app build number
  final String buildNumber;

  /// fetch info and assign to local variables
  static Future<VizzhyAppInfoModel> getInfoOfApp(PackageInfo info) async {
    return VizzhyAppInfoModel(
        info.appName, info.packageName, info.version, info.buildNumber);
  }
}
