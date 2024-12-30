import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/text_input_box_chatgpt.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/vizzhy_ai_services/vizzhy_chatgpt_service.dart';

/// return Audio and Textfiled widget
class VizzhyChatgptAudioButton extends StatelessWidget {
  ///
  VizzhyChatgptAudioButton({
    super.key,
    required this.convController,
    required this.vizzhyAiScreenController,
  });

  /// ConversationController
  final ConversationController convController;

  /// VizzhyAiScreenController
  final VizzhyAiScreenController vizzhyAiScreenController;

  /// VizzhyChatgptService
  final VizzhyChatgptService vizzhyChatgptService = VizzhyChatgptService();

  // /// TextEditingController
  // final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String recentMeal = '';
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextInputBoxChatgpt(
        controller: convController,
        textController: convController.textController,
        hintText: 'Ask anything...',
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
                onTap: vizzhyAiScreenController.isStreamingResponse.value
                    ? () {
                        CustomToastUtil.showFailureToast(
                            message: 'wait for response to Complete');
                      }
                    : () async {
                        FocusScope.of(context).unfocus();
                        vizzhyAiScreenController.sendQuestionToAiChatBot(
                            convController.textController.text);
                        // vizzhyAiScreenController.onAskQuery(
                        //   question: convController.textController.text,
                        // );

                        convController.textController.clear();
                      },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: Get.height * 0.045,
                  child: convController.isListening.value ||
                          vizzhyAiScreenController.isStreamingResponse.value
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
                  convController.textController.clear();
                  convController.startListening();
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
  }
}
