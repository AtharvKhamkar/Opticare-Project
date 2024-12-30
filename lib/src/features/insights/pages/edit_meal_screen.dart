import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dt_picker;
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';

///This screen is used to update previously logged meal
class EditMealScreen extends StatefulWidget {
  ///previous meal foodName
  final String foodName;

  ///previous meal quantity
  final int quantity;

  ///previous meal portion
  final String portion;

  ///previous meal time
  final String time;

  ///previous meal mealDate
  final String mealDate;

  ///previous meal cmiDetailsId(Unique Id of meal).
  final String cmiDetailsId;

  ///Constructor of the EditMealScreen
  const EditMealScreen(
      {super.key,
      required this.foodName,
      required this.quantity,
      required this.portion,
      required this.time,
      required this.cmiDetailsId,
      required this.mealDate});

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  late TextEditingController _foodNameController;
  late TextEditingController _timeController;
  int _selectedQuantity = 1;
  String _selectedPortion = 'Slice';

  @override
  void initState() {
    super.initState();
    _foodNameController = TextEditingController(text: widget.foodName);
    _timeController = TextEditingController(text: widget.time);
    _selectedQuantity = widget.quantity;
    _selectedPortion = widget.portion;

    if (List.generate(10, (index) => index + 1).contains(widget.quantity)) {
      _selectedQuantity = widget.quantity;
    } else {
      _selectedQuantity = 1; // Default to 1 if not in range
    }

    if ([
      'Medium Cup',
      'Small Cup',
      'Small Glass',
      'Medium Glass',
      'Large Glass',
      'Teacup',
      'Bowl/Large Cup',
      'Plate',
      'Tablespoon',
      'Bottle',
      'Can',
      'Peg',
      'Teaspoon',
      'Scoop',
      'Piece',
      'Slice',
      'Pint',
      'Ounce'
    ].contains(widget.portion)) {
      _selectedPortion = widget.portion;
    } else {
      _selectedPortion = 'Slice';
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Cmi details Id is ${widget.cmiDetailsId}');
    debugPrint('Meal date is ${widget.mealDate}');

    final screenHeight = Get.height;
    final screenWidth = Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: 'Edit Meal'),
      body: GetBuilder<MealInputController>(builder: (controller) {
        return Padding(
          padding:
              EdgeInsets.only(left: 16, right: 16, bottom: Get.height * 0.05),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.8),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Food Name',
                          style: TextStyles.headLine3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _foodNameController,
                          style: TextStyles.defaultText,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // No color for focus
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          readOnly: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyles.headLine3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonFormField2<int>(
                                style: TextStyles.defaultText,
                                value: _selectedQuantity,
                                items: List.generate(5, (index) => index + 1)
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.toString(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _selectedQuantity = value!;
                                    },
                                  );
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Colors.grey), // No color for focus
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ),
                                hint: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.grey),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: screenHeight * 0.5,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: AppColors.primaryColorDark,
                                  ),
                                  offset: const Offset(0, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        WidgetStateProperty.all<double>(6),
                                    thumbVisibility:
                                        WidgetStateProperty.all<bool>(true),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Portion',
                                style: TextStyles.headLine3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonFormField2<String>(
                                // dropdownColor: AppColors.primaryColorDark,
                                style: TextStyles.defaultText,
                                value: _selectedPortion,
                                items: controller.availableUnits
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.toString(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _selectedPortion = value!;
                                    },
                                  );
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Colors.grey), // No color for focus
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ),
                                hint: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.grey),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: screenHeight * 0.5,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: AppColors.primaryColorDark,
                                  ),
                                  offset: const Offset(-10, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        WidgetStateProperty.all<double>(6),
                                    thumbVisibility:
                                        WidgetStateProperty.all<bool>(true),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time',
                          style: TextStyles.headLine3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _timeController,
                          style: TextStyles.defaultText,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: Colors.grey.shade600,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // No color for focus
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            ///Default android DateTime Picker Code ----------->

                            // final time = await showTimePicker(
                            //     context: context,
                            //     initialTime: TimeOfDay.now(),
                            //     builder: (BuildContext context, Widget? child) {
                            //       return Theme(
                            //           data: ThemeData.dark().copyWith(
                            //             primaryColor: AppColors.blueColorDark,
                            //             colorScheme: const ColorScheme.dark(
                            //                 primary: AppColors.primaryColor),
                            //             buttonTheme: const ButtonThemeData(
                            //                 textTheme: ButtonTextTheme.accent),
                            //           ),
                            //           child: child!);
                            //     });
                            // if (time != null) {
                            //   setState(() {
                            //     final hour = time.hour.toString().padLeft(2, '0');
                            //     final minute = time.minute.toString().padLeft(2, '0');
                            //     _timeController.text = "$hour:$minute";
                            //   });
                            // }

                            ///Cupertino Picker Code ------------>

                            // final time = await showCupertinoModalPopup<TimeOfDay>(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return Container(
                            //       height: 250,
                            //       child: CupertinoPicker(
                            //         itemExtent: 40,
                            //         onSelectedItemChanged: (int value) {},
                            //         children: List<Widget>.generate(
                            //           24,
                            //           (int index) {
                            //             return Center(
                            //               child: Text(
                            //                 '${index.toString().padLeft(2, '0')}:00',
                            //                 style: const TextStyle(fontSize: 20),
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );

                            ///Timepicker using flutter_datetime_picker_plus code -------->
                            dt_picker.DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onChanged: (date) {
                                debugPrint(
                                    'change $date in time zone ${date.timeZoneOffset.inHours}');
                              },
                              onConfirm: (date) {
                                debugPrint(
                                    'Confirm hours ${date.hour.toString()}');
                                debugPrint(
                                    'Confirm minutes ${date.minute.toString()}');
                                final hour = date.hour.toString();
                                final minutes = date.minute.toString();
                                _timeController.text = "$hour:$minutes";
                              },
                              currentTime: DateTime.now(),
                              theme: dt_picker.DatePickerTheme(
                                backgroundColor: AppColors.appointmentTileColor,
                                itemStyle: TextStyles.headLine2,
                                cancelStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 16),
                                containerHeight: Get.height * 0.2,
                                itemHeight: Get.height * 0.06,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomFormButton(
                        innerText: 'Update',
                        onPressed: () async {
                          await controller.updateMealInput(
                              cmiDetailsId: widget.cmiDetailsId,
                              mealInput: _foodNameController.text,
                              mealType: 'BED TIME',
                              mealTime: _timeController.text,
                              foodUnit: _selectedPortion,
                              mealDate: widget.mealDate,
                              foodQuantity: _selectedQuantity);
                          await AppDialogHandler.mealUploadSuccessDialog(
                              successMessage: 'Food log updated successfully!');
                          Get.back();
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
