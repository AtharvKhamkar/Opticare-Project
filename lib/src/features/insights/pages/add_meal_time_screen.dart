import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

///This screen used to add meal time and meal type like breakfast, lunch, dinner etc.
class AddMealTimeScreen extends StatefulWidget {
  ///Constructor of the AddMealTimeScreen
  const AddMealTimeScreen({super.key});

  @override
  State<AddMealTimeScreen> createState() => _AddMealTimeScreenState();
}

class _AddMealTimeScreenState extends State<AddMealTimeScreen> {
  DateTime selectedTime = DateTime.now();
  final screenHeight = Get.height;
  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors
          .darkBackgroundColor, // Matching the dark theme in the Figma design
      appBar: const CustomAppBar(title: 'Add Meal'),
      body: GetBuilder<MealInputController>(builder: (controller) {
        return Padding(
          padding:
              EdgeInsets.only(left: 16, right: 16, bottom: Get.height * 0.05),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.8),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.035),
                    MealTypeToggleButtons(controller: controller),
                    SizedBox(height: screenHeight * 0.05),
                    const Text(
                      'Enter Meal Time',
                      style: TextStyles.headLine2,
                    ),
                    Text(
                      DateFormat('d MMM h:mm a')
                          .format(controller.mealInputDate.value),
                      style: TextStyles.textFieldHintText,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height:
                          screenHeight * 0.2, // Increase height to match design
                      width: screenWidth,
                      child: CupertinoTheme(
                        data: const CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyles.headLine2,
                          ),
                        ),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          use24hFormat: false,
                          backgroundColor: Colors.transparent,
                          initialDateTime: selectedTime,
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (DateTime newTime) {
                            debugPrint('Chnaged date is ${newTime.toString()}');
                            // controller.mealInputDate.value = newTime.toString();
                            controller.updateMealInputDate(newTime);
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    // SizedBox(
                    //   height: Get.height * 0.1,
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: CustomFormButton(
                          innerText: 'Next',
                          width: screenWidth * 0.5,
                          borderRadius: 16,
                          onPressed: () {
                            // if (controller.selectedMealType.value.isNotEmpty) {
                            //   Get.toNamed('/add-meal-name');
                            // } else {
                            //   CustomToastUtil.showFailureToast(
                            //       message: 'Please select meal type');
                            // }

                            controller.selectedMealType.value.isNotEmpty
                                ? Get.toNamed('/add-meal-name')
                                : CustomToastUtil.showFailureToast(
                                    message: 'Please select meal type');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

///This widget is used to show MealTypes is groupped manned used group_button package.
class MealTypeToggleButtons extends StatelessWidget {
  ///MealInput controller need to pass to access MealType list
  final MealInputController controller;

  ///Constructor for the MealTypeToggleButtons
  const MealTypeToggleButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Which meal would you like to Log?',
          style: TextStyles.headLine2,
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.darkTileColor,
              borderRadius: BorderRadius.all(
                Radius.circular(22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: GroupButton(
                buttons: controller.availableMealTypes,
                options: GroupButtonOptions(
                  selectedShadow: [],
                  selectedTextStyle:
                      TextStyles.headLine2.copyWith(fontSize: 15),
                  selectedColor: Colors.black,
                  unselectedShadow: [],
                  unselectedColor: Colors.transparent,
                  unselectedTextStyle: TextStyles.textFieldHintText2
                      .copyWith(color: Colors.grey, fontSize: 16),
                  selectedBorderColor: AppColors.primaryColor,
                  unselectedBorderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  spacing: Get.width * 0.02,
                  runSpacing: 24,
                  groupingType: GroupingType.wrap,
                  direction: Axis.horizontal,
                  mainGroupAlignment: MainGroupAlignment.start,
                  crossGroupAlignment: CrossGroupAlignment.start,
                  groupRunAlignment: GroupRunAlignment.start,
                  textAlign: TextAlign.center,
                  textPadding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  elevation: 0,
                ),
                onSelected: (value, index, isSelected) {
                  controller.selectedMealType.value =
                      controller.availableMealTypes[index];
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
