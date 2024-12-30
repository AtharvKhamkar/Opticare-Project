import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/features/insights/widgets/date_picker_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/insights/widgets/food_log_list_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';

///This screen is used to display food logs of that respective day.
class FoodLogScreen extends StatefulWidget {
  ///Constructor of the FoodLogScreen
  const FoodLogScreen({super.key});

  @override
  State<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends State<FoodLogScreen> {
  ///MealInputController need to be passed to access FoodLog list of that respective day
  final MealInputController mealController = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());

  @override
  void dispose() {
    super.dispose();
    mealController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: CustomAppBar(
        title: 'Food Logs',
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
                        mealController.updateSelectedDate(selectedDate);
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
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16, vertical: Get.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodLogListWidget(controller: mealController),
            CustomFormButton(
              innerText: 'Add Meal',
              borderRadius: 16,
              onPressed: () {
                Get.toNamed('/add-meal-time');
              },
            ),
          ],
        ),
      ),
    );
  }
}
