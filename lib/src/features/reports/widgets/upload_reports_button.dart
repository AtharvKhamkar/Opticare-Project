import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';

///This widget is used to upload single report
class UploadReportButton extends StatelessWidget {
  ///Need to pass PdfController
  final PdfController controller =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  ///Constructor of the UploadReportButton
  UploadReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        controller.uploadPdf();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text("Upload Report", style: TextStyles.defaultText),
        ),
      ),
    );
  }
}
