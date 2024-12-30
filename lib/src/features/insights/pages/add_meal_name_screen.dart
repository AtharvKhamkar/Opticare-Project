import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/food_suggestion_service.dart';

///Screen is used to add meal name without ASR.
class AddMealNameScreen extends StatefulWidget {
  ///Constructor of the addMealNameScreen
  const AddMealNameScreen({super.key});

  @override
  State<AddMealNameScreen> createState() => _AddMealNameScreenState();
}

class _AddMealNameScreenState extends State<AddMealNameScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;

    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: 'Add Meal'),
      body: GetBuilder<MealInputController>(builder: (mealController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Meal Name',
                style: TextStyles.headLine2,
              ),
              const SizedBox(
                height: 20,
              ),
              TypeAheadField(
                suggestionsCallback: (value) {
                  return FoodSuggestionService.service.getSuggestions(value);
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    readOnly: false,
                    style: TextStyles.headLine2,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        hintText: 'Search food',
                        hintStyle: TextStyles.headLine3,
                        fillColor: AppColors.tileBackgroundColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (controller.text.isEmpty) {
                                CustomToastUtil.showFailureToast(
                                    message: 'Please enter some meal');
                              } else {
                                mealController.textEditingController.text =
                                    controller.text;
                                mealController.update();
                                Get.toNamed('/add-meal-quantity');
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 24,
                            ))),
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    autofocus: false,
                    onTap: () {
                      FoodSuggestionService.service.fetchFoodNamesFromApi();
                    },
                  );
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(
                      suggestion,
                      style: TextStyles.headLine2.copyWith(fontSize: 16),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                decorationBuilder: (context, child) {
                  return Material(
                    type: MaterialType.canvas,
                    elevation: 4,
                    child: Container(
                        decoration:
                            const BoxDecoration(color: AppColors.darkTileColor),
                        child: child),
                  );
                },
                loadingBuilder: (context) {
                  return FoodSuggestionService.service.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : Container();
                },
                emptyBuilder: (context) {
                  return const ListTile(
                    title: Text(
                      'No meal found',
                      style: TextStyles.defaultText,
                    ),
                  );
                },
                onSelected: (String suggestion) {
                  mealController.textEditingController.text = suggestion;
                  mealController.update();

                  Get.toNamed('/add-meal-quantity');
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       Text(
              //         'Frequent Food logs',
              //         style: TextStyles.headLine5.copyWith(fontSize: 13),
              //       ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Roti',
              //       //   quantity: '02',
              //       //   unit: 'Slice',
              //       //   calories: '148 Cal',
              //       // ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Daal',
              //       //   quantity: '01',
              //       //   unit: 'Plate',
              //       //   calories: '225 Cal',
              //       // ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Chapati',
              //       //   quantity: '3',
              //       //   unit: 'Pieces',
              //       //   calories: '300 Cal',
              //       // ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Dosa',
              //       //   quantity: '2',
              //       //   unit: 'Unit',
              //       //   calories: '500 Cal',
              //       // ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Brown bread',
              //       //   quantity: '02',
              //       //   unit: 'Slice',
              //       //   calories: '148 Cal',
              //       // ),
              //       // const EditableFoodLogBox(
              //       //   meal: 'Brown bread',
              //       //   quantity: '02',
              //       //   unit: 'Slice',
              //       //   calories: '148 Cal',
              //       // ),
              //       ListView.builder(
              //         itemCount: FrequentMeals.length,
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) {
              //           final meal = FrequentMeals[index];
              //           return EditableFoodLogBox(
              //               meal: meal['meal'],
              //               quantity: meal['quantity'],
              //               unit: meal['unit'],
              //               calories: meal['calories']);
              //         },
              //       ),
              //       Text(
              //         'Recent Food logs',
              //         style: TextStyles.headLine5.copyWith(fontSize: 13),
              //       ),
              //       ListView.builder(
              //         itemCount: recentMeals.length,
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) {
              //           final meal = recentMeals[index];
              //           return EditableFoodLogBox(
              //               meal: meal['meal'],
              //               quantity: meal['quantity'],
              //               unit: meal['unit'],
              //               calories: meal['calories']);
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // CustomFormButton(
              //     innerText: 'Next',
              //     onPressed: () {
              //       Get.toNamed('/add-meal-quantity');
              //     })
            ],
          ),
        );
      }),
    );
  }
}
