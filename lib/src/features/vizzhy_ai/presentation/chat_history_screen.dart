import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/widgets/vizzhy_ai_chat_history_widgets/chat_history_tile.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final VizzhyAiChatHistoryController controller =
      Get.find<VizzhyAiChatHistoryController>();
  @override
  void initState() {
    super.initState();

    controller.history();

    // Future.delayed(Durations.long2, () {
    //   controller.history();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VizzhyAiChatHistoryController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(title: 'Chat History'),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [buildHistoryWidget(context)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildHistoryWidget(BuildContext context) {
    // Define the current UI state based on controller properties
    final uiState = controller.historyLoading.value
        ? controller.chatHistoryList.isEmpty
            ? 'loadingHistory'
            : 'loadingToggle'
        : controller.chatHistoryList.isEmpty
            ? 'noHistory'
            : 'showHistory';

    Widget getUIState(String state) {
      switch (state) {
        case 'loadingHistory':
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
          );
        case 'noHistory':
          return const Expanded(
            child: Center(
              child: Text(
                'No chat history found',
                style: TextStyles.defaultText,
              ),
            ),
          );
        case 'loadingToggle':
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
          );
        case 'showHistory':
          return Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: controller.chatHistoryList.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  color: AppColors.grayAppointmentTileColor,
                );
              },
              itemBuilder: (_, i) {
                final modal = controller.chatHistoryList[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            modal.duration,
                            style: TextStyles.headLine2
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: List.generate(
                          modal.conversations.length,
                          (subIndex) {
                            final conversation = modal.conversations[subIndex];
                            return ChatHistoryTile(
                              title: conversation.conversation,
                              conversationId: conversation.conversationId,
                              isPinned: modal.duration == 'Pinned',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        default:
          return const SizedBox.shrink(); // Empty widget for unsupported states
      }
    }

    return getUIState(uiState);
  }
}
