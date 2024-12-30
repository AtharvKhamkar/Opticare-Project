// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import '../../../core/constants/constants.dart';

class FoodLogBox extends StatelessWidget {
  final String? text;
  final String time;
  final String mealType;
  final String quantity;
  final String unit;
  final String calories;
  final String cmiDetailsId;
  final String mealDate;
  final MealInputController mealController;

  const FoodLogBox({
    super.key,
    required this.text,
    required this.time,
    required this.mealType,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.mealController,
    required this.cmiDetailsId,
    required this.mealDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/mealInsights', arguments: {
          'text': text ?? 'No food name found',
          'time': time,
          'mealType': mealType,
          'quantity': quantity,
          'unit': unit,
          'calories': calories,
          'mealDate': mealDate,
          'cmiDetailsId': cmiDetailsId
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16), // Adjust padding if needed
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            border: Border.all(width: 1, color: Colors.transparent),
            color: AppColors.darkTileColor
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0x3d4238d2),
            //     Color(0x16a83062),
            //     Color(0x05c159e),
            //   ],
            //   stops: [0.3, 1.0, 0.8],
            // ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text ?? "No food name",
                    style: TextStyles.headLine2
                        .copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 0) {
                      debugPrint('Edit meal is tapped value is $value');
                      Get.toNamed(
                        '/editMeal',
                        arguments: {
                          'foodName': text ?? 'Enter Food name',
                          'quantity': int.parse(quantity),
                          'portion': unit,
                          'time': time,
                          'mealDate': mealDate,
                          'cmiDetailsId': cmiDetailsId
                        },
                      );
                    } else if (value == 1) {
                      debugPrint('Delete meal is tapped');
                      AppDialogHandler.customBottomSheet(
                        message:
                            'Are you sure you want to delete this food Item?',
                        confirmActionMessage: 'Yes, delete',
                        cancelMessage: 'No, do not delete',
                        onConfirmFunction: () {
                          mealController.deleteMeal(cmiDetailsId, mealDate);
                          Get.back();
                        },
                        onCancelFunction: () {
                          Get.back();
                        },
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  color: AppColors.grayTileColor,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Edit Meal',
                            style: TextStyles.defaultText,
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Delete',
                              style: TextStyles.errorAlertText.copyWith(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    time.toLowerCase(),
                    style: TextStyles.TileSubtitleText,
                    textAlign: TextAlign.left,
                  ),
                  _customContainer(),
                  Text(quantity, style: TextStyles.TileSubtitleText),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(unit, style: TextStyles.TileSubtitleText),
                  _customContainer(),
                  Text(calories, style: TextStyles.purpleText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customContainer() {
    return Container(
      height: 15,
      width: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );
  }
}
