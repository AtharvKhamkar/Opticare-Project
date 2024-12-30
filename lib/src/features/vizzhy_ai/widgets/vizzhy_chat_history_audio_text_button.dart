import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/chat_history_text_input_box.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/vizzhy_ai_services/vizzhy_chatgpt_service.dart';

/// return widget of text input
class VizzhyChatHistoryTextInputBox {
  ///
  VizzhyChatHistoryTextInputBox();

  /// initialized vizzhyservice and call widget
  create(
      {required ConversationController convController,
      required VizzhyAiChatHistoryController vizzhyAiChatHistoryController}) {
    vizzhyAiChatHistoryController.vizzhyChatgptService.createInstanceOfOpenAi();
    return _VizzhyChatHistoryAudioTextButton(
      convController: convController,
      vizzhyAiChatHistoryController: vizzhyAiChatHistoryController,
    );
  }
}

/// return Audio and Textfiled widget
class _VizzhyChatHistoryAudioTextButton extends StatelessWidget {
  ///
  _VizzhyChatHistoryAudioTextButton({
    required this.convController,
    required this.vizzhyAiChatHistoryController,
  });

  /// ConversationController
  final ConversationController convController;

  /// VizzhyAiScreenController
  final VizzhyAiChatHistoryController vizzhyAiChatHistoryController;

  /// VizzhyChatgptService
  final VizzhyChatgptService vizzhyChatgptService = VizzhyChatgptService();

  // /// TextEditingController
  // final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String recentMeal = '';
    return Align(
      alignment: Alignment.bottomCenter,
      child: ChatHistoryTextInputBox(
        controller: convController,
        textController: convController.textController,
        hintText: 'Ask anything...',
        suffix: Obx(
          () {
            if (!convController.isTextFieldEmpty.value) {
              return InkWell(
                onTap: vizzhyAiChatHistoryController.isStreamingResponse.value
                    ? () {
                        CustomToastUtil.showFailureToast(
                            message: 'wait for response to Complete');
                      }
                    : () async {
                        FocusScope.of(context).unfocus();
                        vizzhyAiChatHistoryController.sendQuestionToAiChatBot(
                            convController.textController.text);
                        // vizzhyAiChatHistoryController.onAskQuery(
                        //   question: convController.textController.text,
                        // );

                        convController.textController.clear();
                      },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: Get.height * 0.045,
                  child: convController.isListening.value ||
                          vizzhyAiChatHistoryController
                              .isStreamingResponse.value
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
