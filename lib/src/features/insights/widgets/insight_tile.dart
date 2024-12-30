// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/insights/widgets/insights_details_popup.dart';

import '../../../core/constants/constants.dart';

// ignore: must_be_immutable
class InsightTile extends StatelessWidget {
  String title;
  String insightDetails;

  InsightTile({
    super.key,
    required this.title,
    required this.insightDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          InsightsDetailsPopup(
            title: title,
            insightDetails: insightDetails,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Container(
          constraints: BoxConstraints(minHeight: Get.height * 0.09),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.appointmentTileColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  title,
                  style: TextStyles.ButtonText,
                  maxLines: null, // Allow text to wrap to the next line
                  overflow: TextOverflow.visible, // Make overflow visible
                ),
                titleAlignment: ListTileTitleAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
