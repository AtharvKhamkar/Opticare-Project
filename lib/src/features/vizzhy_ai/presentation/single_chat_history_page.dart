import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/chat_message_widget.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/vizzhy_chat_history_audio_text_button.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

class SingleChatHistoryPage extends StatefulWidget {
  final String? conversationId;
  const SingleChatHistoryPage({super.key, this.conversationId});

  @override
  State<SingleChatHistoryPage> createState() => _SingleChatHistoryPageState();
}

class _SingleChatHistoryPageState extends State<SingleChatHistoryPage> {
  final VizzhyAiChatHistoryController controller =
      VizzhyAiChatHistoryController().initialized
          ? Get.find()
          : Get.put(VizzhyAiChatHistoryController());
  final ConversationController convController =
      ConversationController().initialized
          ? Get.find()
          : Get.put(ConversationController());

  final ScrollController chatScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.long2, () {
      loadHistoryChats();
    });

    controller.currentChatList.listen((d) {
      _scrollToBottom();
    });
  }

  loadHistoryChats() {
    if (widget.conversationId!.isNotEmpty) {
      controller.loadChats(widget.conversationId ?? '');
    }
  }

  @override
  void dispose() {
    chatScrollController.dispose();
    convController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: false,
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: 'Opti Care AI',
            backButton: () {
              controller.currentChatList.clear();
              Get.back();
              convController.reset();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Obx(
              () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.isLoading.value)
                      const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    if (!controller.isLoading.value &&
                        controller.currentChatList.isNotEmpty) ...[
                      Expanded(
                        child: ListView.builder(
                          controller: chatScrollController,
                          itemCount: controller.currentChatList.length,
                          // separatorBuilder: (context, index) {
                          //   return const SizedBox(
                          //     height: 24,
                          //   );
                          // },
                          itemBuilder: (_, i) {
                            final singleChat = controller.currentChatList[i];
                            return Column(
                              children: [
                                ChatHistoryMessageWidget(
                                  isSender: true,
                                  isLoading: false,
                                  message: singleChat.question,
                                ),
                                ChatHistoryMessageWidget(
                                  isSender: false,
                                  isLoading:
                                      singleChat.responses.first.isLoading,
                                  message: singleChat.responses.first.resposne,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                    // ElevatedButton(
                    //     onPressed: () {
                    //       controller.onAskQuery(
                    //         question: 'Hey how care you ',
                    //       );
                    //     },
                    //     child: const Text('Call ask query function'))
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.13,
            child: VizzhyChatHistoryTextInputBox().create(
              convController: convController,
              vizzhyAiChatHistoryController: controller,
            ),
          )),
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (chatScrollController.hasClients) {
        // chatScrollController
        //     .jumpTo(chatScrollController.position.maxScrollExtent);
        chatScrollController.animateTo(
            chatScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    });
  }
}
