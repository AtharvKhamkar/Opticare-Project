import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';
import 'package:vizzhy/src/features/reports/widgets/pdf_info_widget.dart';
import 'package:vizzhy/src/features/reports/widgets/upload_reports_button.dart';

import '../../../core/constants/constants.dart';

///This Page is used to display all external reports.
class ExternalReportsPage extends StatelessWidget {
  ///Need to pass PdfController
  final PdfController controller =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  ///Constructor for the external reports page
  ExternalReportsPage({super.key}) {
    controller.fetchReports(); // Fetch reports on page creation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "External Reports"),
      body: GetBuilder<PdfController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
                } else if (controller.externalReports.isEmpty) {
                  return Column(
                    children: [
                      const Spacer(),
                      const Center(
                        child: Text(
                          "No external reports found",
                          style: TextStyles.headLine2,
                        ),
                      ),
                      const Spacer(),
                      UploadReportButton()
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.externalReports.length,
                            itemBuilder: (context, index) {
                              final report = controller.externalReports[index];
                              return PdfInfoWidget(
                                  title: report.reportName,
                                  size: report.status,
                                  url: report.reportUrl);
                            }),
                      ),
                      UploadReportButton()
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
