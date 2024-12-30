import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/features/insights/widgets/date_picker_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_dates_timeline.dart';
import 'package:vizzhy/src/features/insights/widgets/insight_list_widget.dart';

import '../controllers/insights_controller.dart';

///This screen is used to show supplement, Recommendation, Insights
class CarePlan extends StatelessWidget {
  ///Need to pass Insights controller
  final InsightsController controller = InsightsController().initialized
      ? Get.find()
      : Get.put(InsightsController());

  ///Constructor for the CarePlan
  CarePlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: CustomAppBar(
        title: "Care Plan",
        actionWidgets: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: Get.height * 0.5, maxWidth: Get.width * 0.9),
                    child: DatePickerWidget(
                      onDateSelected: (selectedDate) {
                        controller.updateSelectedDate(selectedDate);
                      },
                    ),
                  ),
                ),
              );
            },
            icon: SvgPicture.asset('assets/images/profile/calender.svg'),
          ),
        ],
      ),
      body: GetBuilder<InsightsController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsightsDatesTimeline(
                        controller: controller,
                      ),
                      SizedBox(height: Get.height * 0.04),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       CustomToggleButton(
                      //         label: 'Supplements',
                      //         isSelected: controller.selectedIndex.value == 0,
                      //         onTap: () => controller.updateSelectedIndex(0),
                      //       ),
                      //       CustomToggleButton(
                      //           label: 'Recommendation',
                      //           isSelected: controller.selectedIndex.value == 1,
                      //           onTap: () => controller.updateSelectedIndex(1)),
                      //       CustomToggleButton(
                      //           label: 'Insights',
                      //           isSelected: controller.selectedIndex.value == 2,
                      //           onTap: () => controller.updateSelectedIndex(2)),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: Get.height * 0.04),
                      // Expanded(
                      //   child: Obx(
                      //     () {
                      //       if (controller.selectedIndex.value == 0) {
                      //         return const supplementSection();
                      //       } else if (controller.selectedIndex.value == 1) {
                      //         return const RecommendationSection();
                      //       } else if (controller.selectedIndex.value == 2) {
                      //         return InsightListWidget(
                      //           isLoading: controller.isLoading.value,
                      //           insights: controller.insights,
                      //         );
                      //       } else {
                      //         return const SizedBox();
                      //       }
                      //     },
                      //   ),
                      // )
                      Expanded(
                        child: Obx(
                          () {
                            return InsightListWidget(
                              isLoading: controller.isLoading.value,
                              insights: controller.insights,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
