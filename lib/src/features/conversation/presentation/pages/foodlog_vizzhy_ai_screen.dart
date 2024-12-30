// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/macro_neutrient_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/widgets/audio_button_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/nutrient_tile_widget.dart';

class FoodlogVizzhyAiScreen extends StatefulWidget {
  const FoodlogVizzhyAiScreen({super.key});

  @override
  State<FoodlogVizzhyAiScreen> createState() => _FoodlogVizzhyAiScreenState();
}

class _FoodlogVizzhyAiScreenState extends State<FoodlogVizzhyAiScreen> {
  final MealInputController mealController = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());
  final ConversationController convController =
      ConversationController().initialized
          ? Get.find()
          : Get.put(ConversationController());

  @override
  void dispose() {
    convController.reset();
    mealController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: 'Opti Care AI',
        backButton: () {
          Get.until((route) => route.settings.name == '/conversation');
        },
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: RecentMealBox(convController: convController),
                      ),
                      const DefaultThanksBox(),
                      Row(
                        children: [
                          SvgPicture.asset(
                              'assets/images/profile/chat_suggestion.svg'),
                          NutrientsSuggestionBox(
                            onTap: () async {
                              mealController.showNutrients.value = true;
                              await mealController
                                  .fetchMicroNutrientsByDates(getTodaysDate());
                              await mealController
                                  .fetchMacroNutrientsByDates(getTodaysDate());
                            },
                          ),
                          // NutrientsSuggestionBox(
                          //   onTap: () {},
                          // ),
                          // NutrientsSuggestionBox(
                          //   onTap: () {},
                          // ),
                          // NutrientsSuggestionBox(
                          //   onTap: () {},
                          // ),
                          // NutrientsSuggestionBox(
                          //   onTap: () {},
                          // ),
                        ],
                      ),
                      Obx(() {
                        if (mealController.showNutrients.value) {
                          return NutrientsContainer(controller: mealController);
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
            AudioButtons(
                convController: convController,
                mealInputController: mealController)
          ],
        ),
      ),
    );
  }
}

String getTodaysDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}

class NutrientsSuggestionBox extends StatelessWidget {
  final Function() onTap;

  const NutrientsSuggestionBox({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: AppColors.primaryColor),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: const Text(
          'Tell me my micro and macro nutrients',
          style: TextStyles.defaultText,
        ),
      ),
    );
  }
}

class NutrientsContainer extends StatelessWidget {
  final MealInputController controller;

  const NutrientsContainer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors
                .primaryColor, // You can change the color as per your need
            width: 2.0, // Top border width
          ),
          left: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0, // Left border width
          ),
          right: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0, // Right border width
          ),
          bottom: BorderSide(
            color: AppColors.primaryColor,
            width: 0.3, // Bottom border width
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Macronutrients',
            style: TextStyles.headLine5.copyWith(fontSize: 13),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: AppColors.nutrientsTileColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Obx(
              () {
                if (controller.isMacroByDateLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (controller.macroNutrientsByDates.isEmpty) {
                  return const Center(
                    child: Text(
                      'No macronutrients data found',
                      style: TextStyles.defaultText,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.macroNutrientsByDates.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      MacronutrientModel nutrient =
                          controller.macroNutrientsByDates[index];
                      return NutrientTile(
                        title: nutrient.macronutrientName,
                        value: nutrient.formattedConsumed,
                        color: getColorByRange(nutrient.range),
                        goal: nutrient.formattedGoal,
                        isLast: index ==
                            controller.macroNutrientsByDates.length - 1,
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Micronutrients',
            style: TextStyles.headLine5.copyWith(fontSize: 13),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: AppColors.nutrientsTileColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Obx(
              () {
                if (controller.isMicroByDateLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (controller.micronutrientsByDates.isEmpty) {
                  return const Center(
                    child: Text(
                      'No micronutrients data found',
                      style: TextStyles.defaultText,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.micronutrientsByDates.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      MicronutrientsModel nutrient =
                          controller.micronutrientsByDates[index];
                      return NutrientTile(
                        title: nutrient.micronutrientName.toCapitalCase(),
                        value: nutrient.formattedValue,
                        goal: nutrient.formattedGoal,
                        color: getColorByRange(nutrient.range),
                        unit: nutrient.unit,
                        isLast: index ==
                            controller.micronutrientsByDates.length - 1,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color? getColorByRange(String range) {
  debugPrint("range : $range");
  switch (range) {
    case 'Sufficient':
      return const Color(0xFFFB923C);
    case 'Insufficient':
      return const Color(0xFFF78486);
    case 'Excellent':
      return const Color(0xFF26AC6B);
    case 'Alert/High':
      return const Color(0xFFED0004).withOpacity(0.7);
    case 'Toxic':
      return const Color(0xFFED0004);
    default:
      return null;
  }
}

class RecentMealBox extends StatelessWidget {
  final ConversationController convController;

  const RecentMealBox({
    super.key,
    required this.convController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.75),
      child: GetBuilder<ConversationController>(builder: (controller) {
        return IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  controller.lastInputMeal.value,
                  style: TextStyles.headLine4
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/images/profile/edit.svg'),
              )
            ],
          ),
        );
      }),
    );
  }
}

class DefaultThanksBox extends StatelessWidget {
  const DefaultThanksBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: const Border(
            top: BorderSide(
              color: AppColors
                  .primaryColor, // You can change the color as per your need
              width: 2.0, // Top border width
            ),
            left: BorderSide(
              color: AppColors.primaryColor,
              width: 1.0, // Left border width
            ),
            right: BorderSide(
              color: AppColors.primaryColor,
              width: 1.0, // Right border width
            ),
            bottom: BorderSide(
              color: AppColors.primaryColor,
              width: 0.5, // Bottom border width
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thanks for the information',
              style: TextStyles.defaultText,
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade700,
            )
          ],
        ),
      ),
    );
  }
}
