import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_category_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/foodlog_vizzhy_ai_screen.dart';
import 'package:vizzhy/src/presentation/widgets/nutrient_tile_widget.dart';

///
/// returns list of Miconutrient Tile
/// with categorized and color difference according to range
class MicronutrientsListWidgetByDate extends StatelessWidget {
  ///
  MicronutrientsListWidgetByDate({super.key});

  /// controller used to update ui state
  final MealInputController mealController = Get.find<MealInputController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Loading state
      if (mealController.isSmallLoading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        );
      }

      // No data state
      if (mealController.smallDetailsList.isEmpty) {
        return const Center(
          child: Text(
            'No micronutrients data found',
            style: TextStyles.defaultText,
          ),
        );
      }

      // Data available
      return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: mealController.smallDetailsList.length,
        itemBuilder: (context, index) {
          final category = mealController.smallDetailsList[index];
          return _buildCategorySection(category);
        },
      );
    });
  }

  /// Builds a category section containing a title and a list of nutrients
  Widget _buildCategorySection(MicronutrientsCategoryModel category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category title
        Text(
          category.categoryName.toCapitalCase(),
          style: TextStyles.defaultText.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 10),

        // Nutrients list
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: const BoxDecoration(
            color: AppColors.darkTileColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: _buildNutrientList(category.micronutrients.values.toList()),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Builds a list of nutrients
  Widget _buildNutrientList(List<MicronutrientsModel> nutrients) {
    return ListView.builder(
      itemCount: nutrients.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final nutrient = nutrients[index];
        debugPrint(
            "micro nutrient name and range :${nutrient.micronutrientName} ${nutrient.range}");
        return NutrientTile(
          title: nutrient.micronutrientName.toCapitalCase(),
          value: nutrient.formattedValue,
          goal: nutrient.formattedGoal,
          isLast: index == nutrients.length - 1,
          unit: nutrient.unit,
          color: getColorByRange(nutrient.range),
        );
      },
    );
  }
}
