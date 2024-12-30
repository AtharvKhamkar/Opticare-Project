import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/message_buuble_widget.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/vizzhy_chatgpt_audio_button.dart';
import 'package:vizzhy/src/presentation/widgets/platform_back_button.dart';

class VizzhyAiMainScreen extends StatefulWidget {
  const VizzhyAiMainScreen({super.key});

  @override
  State<VizzhyAiMainScreen> createState() => _VizzhyAiMainScreenState();
}

class _VizzhyAiMainScreenState extends State<VizzhyAiMainScreen> {
  final convController = Get.find<ConversationController>();
  final mealInputController = Get.find<MealInputController>();

  final vizzhyAiController = Get.put(VizzhyAiScreenController());

  final _scrollController = ScrollController();
  @override
  void dispose() {
    convController.reset();
    mealInputController.reset();
    vizzhyAiController.textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // vizzhyChatgptService.createInstanceOfOpenAi();
    vizzhyAiController.conversations.listen((d) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainBackgroundWrapper(
      pageAppBar: AppBar(
        leading: VizzhyPlatformBackButton(onPress: () {
          Get.back();
        }),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/chat-history');
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.transparent,
        title: const Text(
          'Opti Care AI',
          style: TextStyles.appBarTitle,
        ),
        centerTitle: true,
      ),
      page: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (!vizzhyAiController.isLoading.value &&
                    vizzhyAiController.conversations.isEmpty) {
                  return const Center(
                    child: Text(
                      'Ask anything to Opti Care AI...',
                      style: TextStyles.headLine2,
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: vizzhyAiController.conversations.length,
                  itemBuilder: (context, index) {
                    final singleChat = vizzhyAiController.conversations[index];
                    return Column(
                      children: [
                        MessageBubble(
                          isSender: true,
                          isLoading: false,
                          message: singleChat.question,
                        ),
                        MessageBubble(
                          isSender: false,
                          isLoading: singleChat.responses.first.isLoading,
                          message: singleChat.responses.first.resposne,
                        ),
                      ],
                    );
                  },
                  padding: const EdgeInsets.all(16.0),
                );
              },
            ),
          ),
          // ChatInputField(),
          // TextField(
          //   controller: textController,
          //   style: TextStyles.defaultText,
          //   decoration: InputDecoration(
          //       suffixIcon: IconButton(
          //           onPressed: () {
          //             vizzhyAiController.sendQuestionToAiChatBot(
          //                 textController.text,
          //                 vizzhyChatgptService: vizzhyChatgptService);
          //             textController.clear();
          //           },
          //           icon: const Icon(Icons.send, color: Colors.white))),
          // ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.13,
            // color: Colors.red,
            child: VizzhyChatgptAudioButton(
              convController: convController,
              vizzhyAiScreenController: vizzhyAiController,
            ),
          ),
        ],
      ),
    );
  }

  // Function to scroll to the bottom of the ListView when new messages are added
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    });
  }
}

class ChatModel {
  final String question;
  final String questionId;
  final String id;
  final List<ChatResponseModel> responses;

  ChatModel(
      {required this.question,
      required this.questionId,
      required this.id,
      required this.responses});
}

class ChatResponseModel {
  final String resposne;
  final String responseId;
  final bool isLoading;

  ChatResponseModel(
      {required this.resposne,
      required this.responseId,
      this.isLoading = false});
}
