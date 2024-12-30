// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/custom_confirmation_dialog.dart';

import '../../../core/constants/constants.dart';
import '../controllers/pdf_controller.dart';

///This widget is used to display single report.
class PdfInfoWidget extends StatelessWidget {
  final String title;
  final String size;
  final String url;

  PdfInfoWidget({
    super.key,
    required this.title,
    required this.size,
    required this.url,
  });

  final PdfController controller =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
      decoration: const BoxDecoration(
        color: AppColors.darkTileColor,
        // Apply background color with opacity
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: ListTile(
        leading: Image.asset('assets/images/reports/Pdf.png'),
        title: Text(title, style: TextStyles.headLine2),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation to avoid shadow
            shadowColor:
                Colors.transparent, // Ensure the shadow is also transparent
          ),
          onPressed: () {
            Get.dialog(
              CustomConfirmationDialog(
                  message: 'Are you sure you want to download this PDF?',
                  onConfirm: () {
                    controller.downloadPdf(url, title);
                    Get.back();
                  }),
            );
          },
          child: Image.asset(
            'assets/images/reports/DownloadIcon.png',
            color: Colors.white,
          ),
        ),
        onTap: () {
          controller.previewPdf(url, title);
        },
      ),
    );
  }
}
