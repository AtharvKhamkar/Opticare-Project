// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toggle_button.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';
import 'package:vizzhy/src/features/reports/widgets/pdf_info_widget.dart';
import 'package:vizzhy/src/features/reports/widgets/upload_reports_button.dart';

///This screen is used to display both section Vizzhy reports & External reports
class ReportsPage extends StatelessWidget {
  ///Need to pass Pdfcontroller
  final PdfController controller =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  ///Constructor of the Reports page, In constructor calling fetchReports function.
  ReportsPage({super.key}) {
    controller.fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "Reports"),
      body: GetBuilder<PdfController>(
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      bottom: Get.height * 0.05,
                      left: 12,
                      right: 12,
                      top: Get.height * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomToggleButton(
                            label: 'Your Reports',
                            isSelected: controller.selectedIndex.value == 0,
                            onTap: () => controller.updateSelectedIndex(0),
                          ),
                          CustomToggleButton(
                            label: 'External Reports',
                            isSelected: controller.selectedIndex.value == 1,
                            onTap: () => controller.updateSelectedIndex(1),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Expanded(
                        child: Obx(
                          () {
                            if (controller.selectedIndex.value == 0) {
                              return VizzhyReportsSection(
                                  controller: controller);
                            } else if (controller.selectedIndex.value == 1) {
                              return ExternalReportsSection(
                                  controller: controller);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

///This is Seperate section for Vizzhy Reports
class VizzhyReportsSection extends StatelessWidget {
  ///Need to pass PdfController
  final PdfController controller;

  ///constructor of the VizzhyReportsSection
  const VizzhyReportsSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.vizzhyReports.isEmpty) {
      return const Center(
        child: Text(
          "No reports found",
          style: TextStyles.headLine2,
        ),
      );
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
  }
}

///This is Seperate section for External Reports
class ExternalReportsSection extends StatelessWidget {
  ///Need to pass PdfController
  final PdfController controller;

  ///Constructor of the ExternalReportsSection
  const ExternalReportsSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.externalReports.isEmpty) {
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
  }
}
