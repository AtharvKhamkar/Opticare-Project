// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/macro_neutrient_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

class VizzhyAiScreen extends StatefulWidget {
  const VizzhyAiScreen({super.key});

  @override
  State<VizzhyAiScreen> createState() => _VizzhyAiScreenState();
}

class _VizzhyAiScreenState extends State<VizzhyAiScreen> {
  final MealInputController mealController = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());
  final ConversationController convController =
      ConversationController().initialized
          ? Get.find()
          : Get.put(ConversationController());

  @override
  void initState() {
    super.initState();
    mealController.fetchMacroNutrientsByDates(getTodaysDate());
  }

  @override
  Widget build(BuildContext context) {
    final recentMeal = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Opti Care AI'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: RecentMealBox(recentMeal: recentMeal)),
            const DefaultThanksBox(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/profile/chat_suggestion.svg'),
                  NutrientsSuggestionBox(
                    onTap: () {
                      mealController.showNutrients.value = true;
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
            ),
            Text(
              'macronutrients',
              style: TextStyles.headLine5.copyWith(fontSize: 13),
            ),
            const SizedBox(
              height: 20,
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
        height: Get.height * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: AppColors.grayTileColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
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
              itemBuilder: (context, index) {
                MacronutrientModel nutrient =
                    controller.macroNutrientsByDates[index];
                return NutrientTile(
                    title: nutrient.macronutrientName,
                    value: nutrient.consumed,
                    goal: nutrient.goal);
              },
            );
          }
        }));
  }
}

class NutrientTile extends StatelessWidget {
  final String title;
  final double? value;
  final double goal;

  const NutrientTile({
    super.key,
    required this.title,
    required this.value,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyles.defaultText),
              Text(
                '${value?.toStringAsFixed(0) ?? '0'}/${goal.toStringAsFixed(0)}g',
                style: TextStyles.defaultText,
              )
            ],
          ),
        ),
        const Divider(
          thickness: 0.2,
        )
      ],
    );
  }
}

class RecentMealBox extends StatelessWidget {
  final String recentMeal;

  const RecentMealBox({
    super.key,
    required this.recentMeal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.75),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                recentMeal,
                style: TextStyles.headLine4
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/profile/edit.svg'),
            )
          ],
        ),
      ),
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
              'Thanks for logging your food',
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
