// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_controller.dart';

class TextInputBoxChatgpt extends StatelessWidget {
  final TextEditingController textController;
  final ConversationController controller;
  final Widget suffix;

  final String? hintText;

  TextInputBoxChatgpt({
    super.key,
    required this.textController,
    this.hintText = '',
    required this.controller,
    required this.suffix,
  });

  // final VizzhyAiChatHistoryController vizzhyAiChatHistoryController =
  //     Get.find<VizzhyAiChatHistoryController>();

  final VizzhyAiScreenController vizzhyAiScreenController =
      Get.find<VizzhyAiScreenController>();

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
      // decoration: BoxDecoration(
      //   borderRadius:
      //   border: Border.all(width: 2, color: AppColors.primaryColor),
      //   color: Colors.transparent,
      // ),
      child: TextField(
        controller: textController,
        // readOnly: !isEditable,
        style: TextStyles.headLine2,

        decoration: InputDecoration(
            suffixIcon: suffix,

            // prefix: const Padding(
            //   padding: EdgeInsets.only(right: 8.0),
            //   child: Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            // ),
            prefixIcon: IconButton(
              onPressed: () {
                // vizzhyAiChatHistoryController.chatHistoryList.add(
                //     vizzhyAiScreenController.conversations
                //         as ConversationHistory);

                vizzhyAiScreenController.reset();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ),
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
