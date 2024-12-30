// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';

class InsightsDetailsPopup extends StatelessWidget {
  final String title;
  final String insightDetails;

  const InsightsDetailsPopup({
    super.key,
    required this.title,
    required this.insightDetails,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.appointmentTileColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: TextStyles.headLine2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      insightDetails,
                      style: TextStyles.defaultText,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
