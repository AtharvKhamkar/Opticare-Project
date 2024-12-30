import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';

enum DialogueType { info, warning, success, error }

class ErrorHandle {
  static void error(dynamic message) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          "$message",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        margin: EdgeInsets.zero,
        borderRadius: 0,
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 3000),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: DismissDirection.down,
      ),
    );
  }

  static void success(dynamic message,
      {VoidCallback? onAction, String? actionName}) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        messageText: Row(
          children: [
            Expanded(
              child: Text(
                "$message",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (onAction != null)
              InkWell(
                borderRadius: BorderRadius.circular(6.0),
                onTap: onAction,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text(
                    "$actionName".toUpperCase(),
                    style: TextStyles.headLine3,
                  ),
                ),
              )
          ],
        ),
        margin: EdgeInsets.zero,
        borderRadius: 0,
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: DismissDirection.down,
      ),
    );
  }
}
