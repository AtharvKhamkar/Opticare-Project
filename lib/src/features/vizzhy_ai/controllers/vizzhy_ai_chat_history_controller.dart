import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/vizzhy_ai/models/chat_history_model.dart';
import 'package:vizzhy/src/features/vizzhy_ai/models/current_chat_model.dart';
import 'package:vizzhy/src/features/vizzhy_ai/repository/vizzhy_ai_repository.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/vizzhy_ai_services/vizzhy_chatgpt_service.dart';

/// get chat history from api
/// or store to API
/// using this controller
class VizzhyAiChatHistoryController extends GetxController {
  /// repository instance
  final vizzhyAiRepo = VizzhyAiRepository();

  /// store api result of history
  RxList<ConversationHistory> chatHistoryList = <ConversationHistory>[].obs;
  RxBool historyLoading = false.obs;
  RxString errorMessage = ''.obs;
  final historySearchController = TextEditingController();

  RxList<VizzhyChatHistoryNewChatModel> currentChatList =
      <VizzhyChatHistoryNewChatModel>[].obs;

  RxBool isStreamingResponse = false.obs;

  /// when api is called this will be true
  /// use to show loading widget on UI
  RxBool isLoading = false.obs;
  RxString currentConversationId = "".obs;
  RxString currentConverstionTitle = "".obs;

  /// when toggle button is pressed and api call
  RxBool isToggleLoading = false.obs;

  /// vizzhy chatgpt service instance
  final VizzhyChatgptService vizzhyChatgptService = VizzhyChatgptService();

  /// reset all value in controller
  void reset() {
    chatHistoryList.clear();
    isLoading(false);
    isStreamingResponse(false);
    // textController.clear();
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
    currentChatList.add(VizzhyChatHistoryNewChatModel(
      question: question,
      questionId: senderSideChatID,
      id: id,
      responses: [],
    ));

    // isLoading(true);

    /// dump loading message in chat screen

    final thisChatIndex = currentChatList.indexWhere((e) => e.id == id);

    currentChatList[thisChatIndex] = VizzhyChatHistoryNewChatModel(
      question: question,
      questionId: senderSideChatID,
      id: id,
      responses: [
        ChatHistoryResponseModel(responseId: id, resposne: '', isLoading: true)
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
        // isLoading(false);
        isStreamingResponse(false);

        // replace it with resposne and dump in chat screen
        currentChatList[thisChatIndex] = VizzhyChatHistoryNewChatModel(
          question: question,
          questionId: senderSideChatID,
          id: id,
          responses: [
            ChatHistoryResponseModel(
                responseId: id,
                resposne: 'Failed to get response. try again...',
                isLoading: false)
          ],
        );
        return;
      }
      // dumping response in chat screen
      // isLoading(false);
      // replace it with resposne and dump in chat screen
      currentChatList[thisChatIndex] = VizzhyChatHistoryNewChatModel(
        question: question,
        questionId: senderSideChatID,
        id: id,
        responses: [
          ChatHistoryResponseModel(
              responseId: id, resposne: v.message, isLoading: false)
        ],
      );
    }).onDone(() {
      // isLoading(false);
      // when streaming done then allow user to send another question
      isStreamingResponse(false);

      vizzhyAiRepo
          .postCurrentChat(
              conversationId: currentConversationId.value.isEmpty
                  ? null
                  : currentConversationId.value,
              title: currentConverstionTitle.value,
              chatResponse:
                  currentChatList[thisChatIndex].responses.first.resposne,
              prompt: question)
          .then((Map? v) {
        if (v != null) {
          debugPrint("this question is posted on backend : ${v.keys}");
          currentChatList[thisChatIndex] = VizzhyChatHistoryNewChatModel(
              question: question,
              questionId: v['promptId'],
              id: id,
              responses: currentChatList[thisChatIndex].responses);
        }
      });
    });
  }

  /// fetch history details from api
  void history() async {
    if (historyLoading.value) return;
    errorMessage('');
    historyLoading(true);
    update();

    try {
      final value = await vizzhyAiRepo.getChatHistory();
      historyLoading(false);
      chatHistoryList.clear();
      var list = value?.conversationHistory;
      chatHistoryList(list);
      debugPrint('length of the chatHistoryList is ${chatHistoryList.length}');
      update();
    } catch (e) {
      historyLoading(false);
      update();
      debugPrint('Error in history :: VizzhyAiChatHistoryController :: $e');
    }
  }

  Future<void> loadChats(String conversationId) async {
    if (isLoading.value) return;
    isLoading(true);
    currentChatList.clear();
    currentConversationId(conversationId);
    update();

    try {
      final value =
          await vizzhyAiRepo.getCurrentChat(currentConversationId.value);
      isLoading(false);
      currentChatList.clear();

      CurrentChatModel? chat = value;

      for (var element in (chat?.prompt) ?? [] as List<Prompt>) {
        currentChatList.add(VizzhyChatHistoryNewChatModel(
            id: element.uuid,
            question: element.prompt.replaceAll(
                ' Do not give references of files you are referring.', ''),
            questionId: element.promptId,
            responses: element.responses
                .map((e) => ChatHistoryResponseModel(
                    resposne: e.response, responseId: e.responseId))
                .toList()));
      }

      currentConverstionTitle(chat?.title ?? '');

      if (currentChatList.isNotEmpty) {
        // scrollToBottom();
      } else {
        update();
        ErrorHandle.error('Details not available');
      }
    } catch (e) {
      debugPrint('Error in chats :: VizzhyAiScreenController :: $e');
    }
  }

  /// when user toggle pin button
  /// make changes to backend
  void togglePinUnpinConversation(String? conversationId, bool isPinned) {
    try {
      if (isToggleLoading.value) {
        CustomToastUtil.showFailureToast(
            message: 'one task already in progress, please wait..');
        return;
      }
      isToggleLoading(true);
      vizzhyAiRepo.patchPinToggle(convId: conversationId, isPinned: isPinned);
      isToggleLoading(false);
    } catch (e) {
      isToggleLoading(false);
      debugPrint("error while toggeling pin button : $e");
    }
  }
}

class VizzhyAiChatHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VizzhyAiChatHistoryController>(
        () => VizzhyAiChatHistoryController(),
        fenix: true);
  }
}

class VizzhyChatHistoryNewChatModel {
  final String question;
  final String questionId;
  final String id;
  final List<ChatHistoryResponseModel> responses;

  VizzhyChatHistoryNewChatModel(
      {required this.question,
      required this.questionId,
      required this.id,
      required this.responses});
}

class ChatHistoryResponseModel {
  final String resposne;
  final String responseId;
  final bool isLoading;

  ChatHistoryResponseModel(
      {required this.resposne,
      required this.responseId,
      this.isLoading = false});
}
