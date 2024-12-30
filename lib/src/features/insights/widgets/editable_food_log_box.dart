import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';

///Widget to edit Food Log and Used on Add Meal screen in frequest & recent Food logs section.
class EditableFoodLogBox extends StatelessWidget {
  ///Passed meal name
  final String meal;

  ///Passed meal quantity
  final String quantity;

  ///Passed meal unit
  final String unit;

  ///Passed meal calories
  final String calories;

  ///Constructor for the EditableFoodLogBox
  const EditableFoodLogBox(
      {super.key,
      required this.meal,
      required this.quantity,
      required this.unit,
      required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.darkTileColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                meal,
                style: TextStyles.headLine2,
              ),
              IconButton(
                onPressed: () {
                  AppDialogHandler.addMealQuantityBottomSheet(
                      meal: 'Brown bread',
                      onSaveFunction: () {
                        Get.toNamed('/add-meal-quantity');
                      },
                      onEditFunction: () {});
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                quantity,
                style: TextStyles.headLine3.copyWith(height: 24 / 14),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                unit,
                style: TextStyles.headLine3.copyWith(height: 24 / 14),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                calories,
                style: TextStyles.purpleText.copyWith(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
