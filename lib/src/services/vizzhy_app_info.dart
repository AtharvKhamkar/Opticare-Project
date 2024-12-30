import 'package:package_info_plus/package_info_plus.dart';
import 'package:vizzhy/src/services/app_info.dart';

/// By using this service
/// you can get basic Information about our Application
/// for eg:
/// 1.app version
/// 2.app name
/// 3.package name
/// modify this file to get other information then app version
class VizhhyAppInfoService {
  static PackageInfo? _info;

  /// returns app version with buildNumber
  static Future<String> getAppVersion() async {
    _info ??= await PackageInfo.fromPlatform();
    return 'Version : ${_info!.version}+ ${_info!.buildNumber} ';
  }

  /// return full APP Information
  static Future<VizzhyAppInfoModel> getAppInfo() async {
    return await VizzhyAppInfoModel.getInfoOfApp(
        _info ?? await PackageInfo.fromPlatform());
  }
}
