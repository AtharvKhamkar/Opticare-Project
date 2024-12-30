import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/vizzhy_ai/presentation/vizzhy_ai_main_screen.dart';
import 'package:vizzhy/src/features/vizzhy_ai/repository/vizzhy_ai_repository.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/vizzhy_ai_services/vizzhy_chatgpt_service.dart';

/// use this controller to call
/// get chatgpt response on user question
/// update ui
class VizzhyAiScreenController extends GetxController {
  final vizzhyAiRepo = VizzhyAiRepository();

  /// conversation list
  /// holds both message from user as well as chatgpt
  RxList<ChatModel> conversations = <ChatModel>[].obs;

  /// when api is called this will be true
  /// use to show loading widget on UI
  RxBool isLoading = false.obs;

  /// restrict user to ask another question when already response is streaming
  /// returns TRUE when chatgpt resposne is not fully loaded in UI
  RxBool isStreamingResponse = false.obs;

  /// room id
  RxString conversationId = ''.obs;

  /// text controller for question's textfield
  final textController = TextEditingController();

  /// vizzhy chatgpt service instance
  final VizzhyChatgptService vizzhyChatgptService = VizzhyChatgptService();

  @override
  void onInit() {
    super.onInit();
    vizzhyChatgptService.createInstanceOfOpenAi();
  }

  /// reset all value in controller
  void reset() {
    conversations.clear();
    isLoading(false);
    isStreamingResponse(false);
    textController.clear();
    conversationId('');
  }

  /// send user question to openAI api and get response
  /// 1. dump user question in chat screen
  /// 2. make loading TRUE to show loading indicator as chatgpt response
  /// 3. call openAI api to get response
  /// 4. make isStreamingResponse TRUE to restrict user for sending another question in meantime
  /// 5. get response from openAI api and update chat screen with response after replacing Loading message
  Future<void> sendQuestionToAiChatBot(
    String question,
  ) async {
    if (isStreamingResponse.value) {
      CustomToastUtil.showFailureToast(
          message: 'Wait for response to complete');
      return;
    }
    final senderSideChatID = Random().nextInt(190909).toString();
    final id = Random().nextInt(190909).toString();

    /// dump sender's message in chat screen
    conversations.add(ChatModel(
      question: question,
      questionId: senderSideChatID,
      id: id,
      responses: [],
    ));

    isLoading(true);

    /// dump loading message in chat screen

    final thisChatIndex = conversations.indexWhere((e) => e.id == id);

    conversations[thisChatIndex] = ChatModel(
      question: question,
      questionId: senderSideChatID,
      id: id,
      responses: [
        ChatResponseModel(responseId: id, resposne: '', isLoading: true)
      ],
    );

    // make streaming response to True . so that user cant send another question.
    isStreamingResponse(true);

    //prompt after adding do not add reference file
    final String promptToChatGpt =
        '$question. Do not give references of files you are referring.';

    // get response from chatgpt api
    vizzhyChatgptService.getChatResponse(promptToChatGpt).listen((v) {
      // if response is null, then make loading false.
      if (v == null) {
        isLoading(false);
        isStreamingResponse(false);

        // replace it with resposne and dump in chat screen
        conversations[thisChatIndex] = ChatModel(
          question: question,
          questionId: senderSideChatID,
          id: id,
          responses: [
            ChatResponseModel(
                responseId: id,
                resposne: 'Failed to get response. try again...',
                isLoading: false)
          ],
        );
        return;
      }
      // dumping response in chat screen
      isLoading(false);
      // replace it with resposne and dump in chat screen
      conversations[thisChatIndex] = ChatModel(
        question: question,
        questionId: senderSideChatID,
        id: id,
        responses: [
          ChatResponseModel(
              responseId: id, resposne: v.message, isLoading: false)
        ],
      );
    }).onDone(() {
      isLoading(false);
      // when streaming done then allow user to send another question
      isStreamingResponse(false);

      vizzhyAiRepo
          .postCurrentChat(
              conversationId:
                  conversationId.value.isEmpty ? null : conversationId.value,
              title: question,
              chatResponse:
                  conversations[thisChatIndex].responses.first.resposne,
              prompt: question)
          .then((Map? v) {
        if (v != null) {
          debugPrint("this question is posted on backend : ${v.keys}");

          if (conversationId.value.isEmpty) {
            conversationId(v['conversationId']);
          }
          conversations[thisChatIndex] = ChatModel(
              question: question,
              questionId: v['promptId'],
              id: id,
              responses: conversations[thisChatIndex].responses);
        }
      });
    });
  }
}

class VizzhyAiScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VizzhyAiScreenController>(() => VizzhyAiScreenController(),
        fenix: true);
  }
}
