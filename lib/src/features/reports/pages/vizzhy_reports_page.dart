import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';

import '../../../core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import '../widgets/pdf_info_widget.dart';

///This screen is used to display Vizzhy Reports.
class VizzhyReportsPage extends StatelessWidget {
  //Need to pass pdfController;
  final PdfController controller =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  ///Constructor of the VizzhyReports page & calls fetchReports function.
  VizzhyReportsPage({super.key}) {
    controller.fetchReports(); // Fetch Vizzhy reports on page creation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "Vizzhy Reports"),
      body: GetBuilder<PdfController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else if (controller.vizzhyReports.isEmpty) {
            return const Center(
                child: Text(
              "No vizzhy reports found",
              style: TextStyles.headLine2,
            ));
          } else {
            return ListView.builder(
              itemCount: controller.vizzhyReports.length,
              itemBuilder: (context, index) {
                final report = controller.vizzhyReports[index];
                return PdfInfoWidget(
                    title: report.reportName,
                    size: report.status,
                    url: report.reportUrl);
              },
            );
          }
        },
      ),
    );
  }
}
