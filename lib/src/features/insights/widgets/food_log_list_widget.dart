// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/insights/widgets/view_foodlog_bydate_insight_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_dates_timeline.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/insights/widgets/food_log_box.dart';

class FoodLogListWidget extends StatefulWidget {
  final MealInputController controller;

  const FoodLogListWidget({
    super.key,
    required this.controller,
  });

  @override
  State<FoodLogListWidget> createState() => _FoodLogListWidgetState();
}

class _FoodLogListWidgetState extends State<FoodLogListWidget> {
  String get selectedDate => widget.controller.selectedDate.value.toString();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchMealInputsByDates(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building FoodLogListWidget again');
    return Expanded(
      child: Column(
        children: [
          CustomDatesTimeline(
            controller: widget.controller,
          ),
          SizedBox(height: Get.height * 0.035),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Get.to(() => MainBackgroundWrapper(
                        page: ViewFoodlogBydateInsightWidget(
                          date: selectedDate,
                        ),
                      ));
                },
                child: const Text(
                  'View Insights',
                  style: TextStyles.purpleText,
                )),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Expanded(
            child: Obx(
              () {
                if (widget.controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  );
                }

                if (widget.controller.mealInputsByDates.isEmpty) {
                  return const Center(
                    child: Text(
                      'No meal logged for this day',
                      style: TextStyles.defaultText,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    widget.controller.fetchMealInputsByDates(selectedDate);
                  },
                  child: ListView.builder(
                    itemCount: widget.controller.mealInputsByDates.length,
                    itemBuilder: (context, index) {
                      final mealInput =
                          widget.controller.mealInputsByDates[index];

                      debugPrint('Reached in the 1st listview builder');

                      return Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: mealInput.foodItems?.length ?? 0,
                            itemBuilder: (context, foodIndex) {
                              final foodItem = mealInput.foodItems?[foodIndex];
                              if (foodItem == null) {
                                return const SizedBox();
                              }

                              //Meal Time according to the timestamp at which user is logging meal
                              debugPrint('reached in the ListView Builder');

                              // final DateTime mealDateTime =
                              //     DateTime.parse(foodItem.createdAt!).toLocal();
                              // final String formattedTime = DateFormat('hh:mm a')
                              //     .format(mealDateTime)
                              //     .toString();
                              // final String formattedDate =
                              //     DateFormat('yyyy-MM-dd').format(mealDateTime);
                              // debugPrint(
                              //     'Passing date from foodlogList widget ${foodItem.food!.foodName} --------> $formattedDate');

                              //If user has mentioned meal time in the promt then shows that meal time else It will shouw timestamp at which user has logged meal

                              String localTime = foodItem.localTime!
                                  .replaceAll(RegExp(r'\s?[AP]M'), '');
                              DateTime parsedDate =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .parse(localTime);
                              final String formattedTime =
                                  DateFormat('hh:mm a').format(parsedDate);
                              final String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(parsedDate);

                              debugPrint(
                                  'Passing date from foodlogList widget ${foodItem.food!.foodName} --------> $formattedDate');

                              return FoodLogBox(
                                text: foodItem.food!.foodName,
                                time: formattedTime,
                                mealType: foodItem.mealType ?? '-',
                                quantity: foodItem.food!.quantity.toString(),
                                unit: foodItem.food?.unit ?? 'unit',
                                calories:
                                    '${foodItem.vfs?.calories?.value.toString() ?? "0"} ${foodItem.vfs?.calories?.unit ?? "kcal"}',
                                cmiDetailsId: foodItem.cmiDetailsId!,
                                mealDate: formattedDate,
                                mealController: widget.controller,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
