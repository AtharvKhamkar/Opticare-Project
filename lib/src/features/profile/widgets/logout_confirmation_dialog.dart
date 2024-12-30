import 'dart:ui'; // Needed for the BackdropFilter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///Added this class to add Confirmation dialog while logging out
class LogoutConfirmationDialog extends StatelessWidget {
  ///This is a constructor of the logout confirmation class
  const LogoutConfirmationDialog({super.key});

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
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Are you sure you want to logout your account?',
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
                        child: const Text(
                          "NO",
                          style: TextStyle(
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
                        onPressed: () {
                          AppStorage.logout();
                          Get.back(); // Close the dialog
                        },
                        child: const Text(
                          "YES",
                          style: TextStyle(
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
