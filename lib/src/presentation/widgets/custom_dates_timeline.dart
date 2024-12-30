import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/insights/controllers/insights_controller.dart';

///This widget is used to show dates timeline in the foodlogs page need to pass MealInputController
class CustomDatesTimeline extends StatelessWidget {
  ///MealInputController
  final MealInputController controller;

  ///Contructor
  const CustomDatesTimeline({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => EasyInfiniteDateTimeLine(
        showTimelineHeader: false,
        selectionMode: const SelectionMode.autoCenter(),
        firstDate: DateTime(controller.selectedDate.value.year,
            controller.selectedDate.value.month, 1),
        lastDate: DateTime.now(),
        dayProps: const EasyDayProps(
          // You must specify the width in this case.
          width: 65.0,
          // The height is not required in this case.
          height: 86.0,
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
        ),
        itemBuilder: (
          BuildContext context,
          DateTime date,
          bool isSelected,
          VoidCallback onTap,
        ) {
          // Use Obx only here to reactively watch controller.selectedDate
          return Obx(
            () {
              final bool isDateSelected =
                  date.day == controller.selectedDate.value.day &&
                      date.month == controller.selectedDate.value.month &&
                      date.year == controller.selectedDate.value.year;
              return GestureDetector(
                onTap: () {
                  controller.updateSelectedDate(date);
                  onTap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDateSelected
                        ? AppColors.primaryColor
                        : AppColors.darkTileColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          EasyDateFormatter.shortDayName(date, "en_US"),
                          style: TextStyles.headLine5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        focusDate: controller.selectedDate.value,
      ),
    );
  }
}

///This widget is used to show DateTime line on the CarePlan page need to pass InsightsController
class InsightsDatesTimeline extends StatelessWidget {
  ///InsightsController
  final InsightsController controller;

  ///Constructor
  const InsightsDatesTimeline({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => EasyInfiniteDateTimeLine(
        showTimelineHeader: false,
        selectionMode: const SelectionMode.autoCenter(),
        firstDate: DateTime(controller.selectedDate.value.year,
            controller.selectedDate.value.month, 1),
        lastDate: DateTime.now(),
        dayProps: const EasyDayProps(
          // You must specify the width in this case.
          width: 65.0,
          // The height is not required in this case.
          height: 86.0,
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
        ),
        itemBuilder: (
          BuildContext context,
          DateTime date,
          bool isSelected,
          VoidCallback onTap,
        ) {
          // Use Obx only here to reactively watch controller.selectedDate
          return Obx(
            () {
              final bool isDateSelected =
                  date.day == controller.selectedDate.value.day &&
                      date.month == controller.selectedDate.value.month &&
                      date.year == controller.selectedDate.value.year;
              return GestureDetector(
                onTap: () {
                  controller.updateSelectedDate(date);
                  onTap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDateSelected
                        ? AppColors.primaryColor
                        : AppColors.darkTileColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          EasyDateFormatter.shortDayName(date, "en_US"),
                          style: TextStyles.headLine5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        focusDate: controller.selectedDate.value,
      ),
    );
  }
}
