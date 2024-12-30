import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/foodlog_vizzhy_ai_screen.dart';
import 'package:vizzhy/src/presentation/widgets/nutrient_tile_widget.dart';

class MacronutrientsListWidgetByMeal extends StatelessWidget {
  MacronutrientsListWidgetByMeal({
    super.key,
  });

  final MealInputController mealcontroller = Get.find<MealInputController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mealcontroller.isBigLoading.value) {
          return const Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ));
        }
        if (mealcontroller.bigDetailsList.isEmpty &&
            !mealcontroller.isBigLoading.value) {
          return const Center(
            child: Text(
              'No macronutrients data found',
              style: TextStyles.defaultText,
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.darkTileColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListView.builder(
                itemCount: mealcontroller.bigDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final nutrient = mealcontroller.bigDetailsList[index];
                  return NutrientTile(
                    title: nutrient.macronutrientName,
                    value: nutrient.formattedConsumed,
                    color: getColorByRange(nutrient.range),
                    goal: nutrient.formattedGoal,
                    isLast: index == mealcontroller.bigDetailsList.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
