import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtil {
  Future<void> launchURL(String url, {LaunchMode? mode}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: mode ?? LaunchMode.inAppWebView,
      );
    } else {
      throw 'Could not launch URL';
    }
  }

  static String uniqueId() {
    const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    String id = '';

    for (var i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(charset.length);
      id += charset[randomIndex];
    }

    return id;
  }

  Future<File?> chooseFile(
      {FileType type = FileType.any, List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: type, allowedExtensions: allowedExtensions);
      debugPrint('$result');

      if (result != null && result.files.isNotEmpty) {
        debugPrint(result.files.single.path!);
        return File(result.files.single.path!);
      }
    } catch (e) {
      debugPrint('chooseFile error:$e');
    }
    return null;
  }

  ///Capitalize first letter of the word
  static String? capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) return input;
    return '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}';
  }
}
