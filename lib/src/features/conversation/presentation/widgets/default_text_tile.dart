import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/presentation/vizzhy_ai_main_screen.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

import '../../../../core/constants/constants.dart';

class DefaultTextTile extends StatelessWidget {
  final ConversationController convController;
  const DefaultTextTile({super.key, required this.convController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Opti Care AI is Listening',
            style: TextStyles.headLine2
                .copyWith(fontWeight: FontWeight.w400, fontSize: 22),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          const Text(
            'Tap the mic and speak',
            style: TextStyles.headLine3,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint('ASR button is clicked');
                  Get.toNamed('/speech-to-text');
                  convController.textController.clear();
                  convController.startListening();
                },
                child: const SuggestionBox(
                  title: 'Log your food',
                  assetPath: 'assets/images/profile/dining.svg',
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('Vizzhy AI button clicked');
                  final assistanceId = AppStorage.getAssistanceId();
                  if (assistanceId.isNotEmpty) {
                    Get.to(const VizzhyAiMainScreen(),
                        binding: VizzhyAiScreenControllerBinding());
                    // Get.to(() => const MainBackgroundWrapper(
                    //         page: VizzhyAi(
                    //       conversationId: '',
                    //     )));
                  } else {
                    CustomToastUtil.showFailureToast(
                        message:
                            'AssistanceId is required to use VizzhyAI feature');
                  }
                },
                child: const SuggestionBox(
                  title: 'Ask Anything',
                  assetPath: 'assets/images/profile/vizzhy_ai_bot.svg',
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SuggestionBox(
                title: 'Upload reports',
                assetPath: 'assets/images/profile/upload.svg',
                size: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SuggestionBox extends StatelessWidget {
  final String assetPath;
  final String title;
  final double size;
  const SuggestionBox(
      {super.key,
      required this.assetPath,
      required this.title,
      this.size = 24});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final screenWidth = Get.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.001, horizontal: screenWidth * 0.02),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              assetPath,
              height: size,
              width: size,
              // color: Colors.white,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          Text(
            title,
            style: TextStyles.headLine3,
          ),
        ],
      ),
    );
  }
}
