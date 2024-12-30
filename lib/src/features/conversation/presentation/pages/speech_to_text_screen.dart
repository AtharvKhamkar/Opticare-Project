import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:vizzhy/src/features/conversation/presentation/widgets/editable_meal_input_box.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/presentation/widgets/platform_back_button.dart';

/// Speech to Text Screen
/// when user press or Select
/// Food log for entry
/// user will be redirected to this screen
/// ASR will automatically enabled
/// and user can input details via Speech
/// or can manuallyy Type in the textfiled present in the bottom of the screen
class SpeechToTextScreen extends StatefulWidget {
  ///
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final AuthController authController =
      AuthController().initialized ? Get.find() : Get.put(AuthController());
  final MealInputController mealController = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());
  final ConversationController convController =
      ConversationController().initialized
          ? Get.find()
          : Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    final userDetails = AppStorage.getUserLoginDetails();
    // var recognizedText = '';
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus();
        convController.textController.clear();
        convController.reset();
        mealController.reset();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: VizzhyPlatformBackButton(onPress: () {
            Get.back();
          }),
          backgroundColor: Colors.transparent,
          title: ConvScreenAppBar(
            userName: '${userDetails.firstName} ${userDetails.lastName}',
            // userNameColor: AppColors.getRandomColor(),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Get.height * 0.04, horizontal: 12),
          child: Column(
            children: [
              const Spacer(),
              Obx(
                () {
                  if (convController.isListening.value) {
                    return const Text(
                      'Listening...',
                      style: TextStyles.defaultText,
                    ).animate().fadeIn(
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Obx(() {
                if (convController.isListening.value) {
                  return Center(
                    child: Lottie.asset('assets/animations/wave_animation.json',
                        fit: BoxFit.fill),
                  );
                } else {
                  return const SizedBox();
                }
              }),
              const Spacer(),
              SendMealBox(
                convController: convController,
                mealInputController: mealController,
              )
            ],
          ),
        ),
      ),
    );
  }
}

///
class RecognizedMealBox extends StatelessWidget {
  /// whether to enable editing for user
  final bool isEditable;

  /// Controller for textfield
  final TextEditingController textController;

  /// hint Text
  final String? hintText;

  ///
  final MealInputController mealInputController;

  ///
  final ConversationController convController;

  /// constructor of the widget
  const RecognizedMealBox({
    super.key,
    // required this.text,
    required this.isEditable,
    required this.textController,
    this.hintText,
    required this.mealInputController,
    required this.convController,
  });

  @override
  Widget build(BuildContext context) {
    // textController.value = TextEditingValue(text: text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            convController.textController.text = '';
            convController.stopListening();
            mealInputController.reset();
            convController.reset();
            Get.back();
          },
          icon: SvgPicture.asset('assets/images/profile/wrong_sign.svg'),
        ),
        Expanded(
          child: TextField(
            controller: textController,
            readOnly: false,
            style: TextStyles.headLine2,
            decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyles.headLine3),
            maxLines: null,
          ),
        ),
        IconButton(
          onPressed: () {
            mealInputController.isMealCorrect(true);
            convController.stopListening();
          },
          icon: SvgPicture.asset('assets/images/profile/correct_sign.svg'),
        ),
      ],
    );
  }
}

///
class SendMealBox extends StatelessWidget {
  ///
  const SendMealBox({
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: MealInputBox(
        isEditable: true,
        textController: convController.textController,
        hintText: 'Log your daily food',
        controller: convController,
        suffix: InkWell(
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   shadowColor: Colors.transparent,
          // ),
          onTap: () async {
            if (convController.textController.text.isNotEmpty) {
              recentMeal = convController.textController.text;
              if (recentMeal.trim().isEmpty) {
                CustomToastUtil.showFailureToast(
                    message: 'Please log some meal!');
              }
              final val = await mealInputController
                  .postMealInput(convController.textController.text);
              debugPrint('$val');
              if (val) {
                debugPrint('Meal report sent successfully');
                convController.lastInputMeal.value =
                    convController.textController.text;
                mealInputController.reset();
                convController.reset();
                convController.update();
                Get.offNamed('/vizzhyAI');
                CustomToastUtil.showSucessToast(
                    message: 'Meal log posted successfully');
              }
            } else {
              CustomToastUtil.showFailureToast(message: 'Failed to log meal');
            }
          },
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: Get.height * 0.0425,
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
        ),
      ),
    );
  }
}
