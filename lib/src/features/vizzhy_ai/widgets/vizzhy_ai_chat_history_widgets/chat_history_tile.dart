import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/presentation/single_chat_history_page.dart';

/// return a chat history tile widget
class ChatHistoryTile extends StatefulWidget {
  /// title of the chat
  final String title;

  /// whether this chat historyy is pinned or not
  final bool isPinned;
  final String conversationId;

  ///
  const ChatHistoryTile(
      {super.key,
      required this.title,
      required this.conversationId,
      required this.isPinned});

  @override
  State<ChatHistoryTile> createState() => _ChatHistoryTileState();
}

class _ChatHistoryTileState extends State<ChatHistoryTile> {
  // bool isPinned = false;

  final chatHistoryController = Get.find<VizzhyAiChatHistoryController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => MainBackgroundWrapper(
            page: SingleChatHistoryPage(
              conversationId: widget.conversationId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                'assets/images/profile/message.svg',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyles.headLine2.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    chatHistoryController.togglePinUnpinConversation(
                        widget.conversationId, !widget.isPinned);

                    Future.delayed(Durations.medium2,
                        () => chatHistoryController.history());
                    // setState(() {
                    //   isPinned = !isPinned;
                    // });
                  },
                  child: Icon(
                    widget.isPinned
                        ? Icons.push_pin_rounded
                        : Icons.push_pin_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: const Icon(
                //     Icons.more_vert,
                //     color: Colors.white,
                //     size: 20,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
