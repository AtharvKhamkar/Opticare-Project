// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';

class ChatHistoryTextInputBox extends StatelessWidget {
  final TextEditingController textController;
  final ConversationController controller;

  final String? hintText;
  final Widget suffix;

  ChatHistoryTextInputBox({
    super.key,
    required this.textController,
    required this.suffix,
    this.hintText = '',
    required this.controller,
  });

  // final VizzhyAiChatHistoryController vizzhyAiChatHistoryController =
  //     Get.find<VizzhyAiChatHistoryController>();

  final VizzhyAiChatHistoryController vizzhyAiChatHistoryController =
      Get.find<VizzhyAiChatHistoryController>();

  final buttonBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.015,
        horizontal: 10,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        controller: textController,
        // readOnly: !isEditable,
        style: TextStyles.headLine2,
        decoration: InputDecoration(
            suffixIcon: suffix,
            // prefixIcon: IconButton(
            //   onPressed: () {
            //     // vizzhyAiChatHistoryController.chatHistoryList.add(
            //     //     vizzhyAiScreenController.conversations
            //     //         as ConversationHistory);

            //     vizzhyAiChatHistoryController.reset();
            //   },
            //   icon: const Icon(
            //     Icons.add,
            //     color: Colors.white,
            //     size: 24,
            //   ),
            // ),
            focusedBorder: buttonBorder,
            enabledBorder: buttonBorder,
            border: buttonBorder,
            errorBorder: buttonBorder,
            focusedErrorBorder: buttonBorder,
            disabledBorder: buttonBorder,
            isDense: true,
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyles.headLine2.copyWith(color: Colors.grey)),
        maxLines: null,
        textInputAction: TextInputAction.done,
        autofocus: false,
      ),
    );
  }
}
