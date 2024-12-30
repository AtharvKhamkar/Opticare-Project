import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/widgets/editable_meal_input_box.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/presentation/vizzhy_ai_main_screen.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

/// ASR feature with textFiled
class AudioButtons extends StatelessWidget {
  ///
  const AudioButtons({
    super.key,
    required this.convController,
    required this.mealInputController,
  });

  ///
  final ConversationController convController;

  ///
  final MealInputController mealInputController;

  @override
  Widget build(BuildContext context) {
    String recentMeal = '';
    return Obx(() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: MealInputBox(
          isEditable: convController.isEditable.value,
          textController: convController.textController,
          controller: convController,
          hintText: 'Ask Anything...',
          suffix: Obx(
            () {
              if (!convController.isTextFieldEmpty.value) {
                return InkWell(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors
                  //       .transparent, // Set the background color to transparent
                  //   elevation: 0, // Remove the elevation to avoid shadow
                  //   shadowColor: Colors
                  //       .transparent, // Ensure the shadow is also transparent
                  // ),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (convController.textController.text.isNotEmpty) {
                      recentMeal = convController.textController.text;
                      if (recentMeal.trim().isEmpty) {
                        CustomToastUtil.showFailureToast(
                            message: 'Please log some meal!');
                      }
                      debugPrint(
                          'Post request send from the conv screen $recentMeal');
                      final val = await mealInputController
                          .postMealInput(convController.textController.text);
                      debugPrint(
                          'Response from server of postMealInput : $val');
                      if (val) {
                        debugPrint('Meal report sent successfully');
                        convController.lastInputMeal.value =
                            convController.textController.text;
                        mealInputController.reset();
                        convController.reset();
                        convController.update();

                        Get.toNamed('/vizzhyAI');
                        CustomToastUtil.showSucessToast(
                            message: 'Meal log posted successfully');
                      }
                    } else {
                      CustomToastUtil.showFailureToast(
                          message: 'Failed to log meal');
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    // radius: 24,
                    radius: Get.height * 0.045,
                    child: mealInputController.isPostMealLoader.value
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_upward_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                );
              } else {
                return InkWell(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors
                  //       .transparent, // Set the background color to transparent
                  //   elevation: 0, // Remove the elevation to avoid shadow
                  //   shadowColor: Colors
                  //       .transparent, // Ensure the shadow is also transparent
                  // ),
                  onTap: () {
                    AppDialogHandler.showChooseAsrDialog(onVizzhyAiClick: () {
                      debugPrint('Vizzhy AI button clicked');
                      final assistanceId = AppStorage.getAssistanceId();
                      if (assistanceId.isNotEmpty) {
                        // Get.to(const VizzhyAiMainScreen());
                        Get.to(
                            () => const VizzhyAiMainScreen(
                                // conversationId: '',
                                ),
                            binding: VizzhyAiScreenControllerBinding());
                      } else {
                        CustomToastUtil.showFailureToast(
                            message:
                                'AssistanceId is required to use VizzhyAI feature');
                      }
                    }, onAsrClick: () {
                      debugPrint('ASR button is clicked');
                      Get.toNamed('/speech-to-text');
                      convController.textController.clear();
                      convController.startListening();
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: Get.height * 0.045,
                    child: SvgPicture.asset(
                      'assets/images/profile/mic.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    });
  }
}
