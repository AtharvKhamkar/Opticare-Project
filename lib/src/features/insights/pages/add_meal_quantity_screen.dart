import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';

///This screen is used to add quantity and portion of the meal
class AddMealQuantityScreen extends StatefulWidget {
  ///constructor of the AddMealQuantityScreen
  const AddMealQuantityScreen({super.key});

  @override
  State<AddMealQuantityScreen> createState() => _AddMealQuantityScreenState();
}

class _AddMealQuantityScreenState extends State<AddMealQuantityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: ''),
      body: GetBuilder<MealInputController>(builder: (controller) {
        return Padding(
          padding:
              EdgeInsets.only(left: 16, right: 16, bottom: Get.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              Text(
                controller.textEditingController.text,
                style: TextStyles.headLine1,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pick Quantity',
                style: TextStyles.ButtonText.copyWith(
                    fontWeight: FontWeight.normal),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Get.height * 0.2,
                      child: CupertinoPicker(
                        itemExtent: 64.0,
                        onSelectedItemChanged: (index) {
                          controller.selectedQuantity(index + 1);
                        },
                        children: List.generate(
                          5,
                          (index) => Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyles.defaultText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Get.height * 0.2,
                      child: CupertinoPicker(
                        itemExtent: 64.0,
                        onSelectedItemChanged: (index) {
                          controller
                              .selectedUnits(controller.availableUnits[index]);
                        },
                        children: controller.availableUnits
                            .map((unit) => Center(
                                  child:
                                      Text(unit, style: TextStyles.headLine2),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: CustomFormButton(
                    innerText: 'Save',
                    width: Get.width * 0.5,
                    borderRadius: 16,
                    onPressed: () async {
                      debugPrint(
                          'Passed date is ${controller.selectedDate.toString().split(" ")[0]}');
                      await controller.postMealInputsByDate(
                        mealInput: controller.textEditingController.text,
                        mealType: controller.selectedMealType.value
                            .toUpperCase(), //Need to pass meal type only in upper case else it will give error
                        mealTime: controller.mealInputDate.toString(),
                        mealDate:
                            controller.mealInputDate.toString().split(" ")[0],
                        foodUnit: controller.selectedUnits.toString(),
                        foodQuantity: controller.selectedQuantity.toInt(),
                      );
                      controller.reset();
                      await AppDialogHandler.mealUploadSuccessDialog(
                          successMessage: 'Food log added successfully!');
                      debugPrint('Navigating to foodlog');
                      // Get.offNamedUntil(
                      //     '/food-log',
                      //     (route) =>
                      //         route.settings.name == '/conversation' ||
                      //         route.settings.name == '/profile');
                      // Get.offNamedUntil('/food-log', (route) => true);
                      Get.until((route) => route.settings.name == '/food-log');
                      controller.fetchMealInputsByDates(
                          controller.selectedDate.value.toString());
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
