import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

class ChatHistoryMessageWidget extends StatelessWidget {
  /// text message
  final String message;

  /// this message is sent by app user?
  /// return false if this chat message is from chatgpt
  final bool isSender;

  /// show laoding widget if response is yet to come
  final bool isLoading;

  ///
  const ChatHistoryMessageWidget(
      {super.key,
      this.isLoading = false,
      required this.message,
      required this.isSender});

  @override
  Widget build(BuildContext context) {
    // isLoading = false;
    return SizedBox(
      // width: Get.width,
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.7,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: !isSender ? const Color.fromRGBO(174, 174, 174, 0.12) : null,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: isSender
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: isSender
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
            border:
                isSender ? null : Border.all(color: Colors.purple, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                // fit: FlexFit.tight,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ))
                    // : Text(
                    //     message,
                    //     textAlign: isSender ? TextAlign.end : null,
                    //     style: const TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 14,
                    //       height: 1.5,
                    //     ),
                    //   ),
                    : MarkdownBody(
                        data: message,
                        selectable: true,
                        styleSheet: MarkdownStyleSheet(
                          textAlign: isSender
                              ? WrapAlignment.end
                              : WrapAlignment.start,
                          code: TextStyles.defaultText,
                          codeblockDecoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          p: TextStyles.headLine2.copyWith(fontSize: 17),
                          h3: TextStyles.headLine1,
                          strong: TextStyles.headLine2
                              .copyWith(fontWeight: FontWeight.w600),
                          listBullet: TextStyles.headLine2
                              .copyWith(fontWeight: FontWeight.w600),
                          tableBorder:
                              TableBorder.all(color: Colors.grey, width: 0.4),
                          tableCellsPadding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 4),
                          tableHead: TextStyles.headLine2,
                          tableBody: TextStyles.defaultText,
                          tableHeadAlign: TextAlign.center,
                          tableVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                        ),
                        styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                      ),
              ),
              //
              if (isSender) ...[
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      // Define edit action here
                    },
                    child: SvgPicture.asset('assets/Icons/edit_icon.svg',
                        placeholderBuilder: (context) => const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                        width: 20)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
