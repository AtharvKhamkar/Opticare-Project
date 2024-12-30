import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';

import '../../../core/constants/constants.dart';

///This widget is used to confirm that user want to download reports or not
class PdfConfirmationDialog extends StatelessWidget {
  /// pdf url
  final String url;

  /// title of the pdf
  final String title;

  ///Constructor of the PdfConfirmationDialog
  const PdfConfirmationDialog({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());
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
                    "Are you sure you want to download this PDF?",
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
                          pdfController.downloadPdf(url, title);
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
