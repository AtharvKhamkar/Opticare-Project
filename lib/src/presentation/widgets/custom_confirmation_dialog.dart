// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String message;
  final void Function() onConfirm;
  final String confirmText;
  final String cancelText;

  const CustomConfirmationDialog({
    super.key,
    required this.message,
    required this.onConfirm,
    this.confirmText = "Yes",
    this.cancelText = "No",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: const EdgeInsets.all(0),
      iconPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff292929)
                  .withOpacity(0.9), // Semi-transparent background
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    message,
                    style: TextStyles.headLine2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                    endIndent: 0,
                    thickness: 0,
                    height: 0,
                    color: Colors.grey), // Add a divider after the content
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back(); // Close the dialog
                        },
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 0.5,
                      color: Colors.grey, // Add vertical divider
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: onConfirm,
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
