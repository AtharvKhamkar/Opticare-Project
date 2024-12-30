// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/widgets/audio_button_widget.dart';
import 'package:vizzhy/src/features/conversation/presentation/widgets/default_text_tile.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';

import '../../../../core/constants/constants.dart';
import '../controller/conversation_controller.dart';

/// It is a main screen
/// when app launch and user is logged In
/// then this page will act as a homepage
class ConversationScreen extends StatefulWidget {
  ///constructor
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final AuthController authController =
      AuthController().initialized ? Get.find() : Get.put(AuthController());
  final MealInputController mealController = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());
  final ConversationController convController =
      ConversationController().initialized
          ? Get.find()
          : Get.put(ConversationController());

  final PdfController pdfController =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  final userDetails = AppStorage.getUserLoginDetails();

  void _onWillPop(bool didPop, dynamic result) async {
    if (convController.recognizedText.isNotEmpty) {
      convController.reset();
      mealController.reset();
      return;
    } else {
      AppDialogHandler.logoutBottomSheet();
      return;
    }
  }

  // late Color userNameColor;

  @override
  void initState() {
    super.initState();
    // userNameColor = AppColors.getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: ConvScreenAppBar(
                userName: '${userDetails.firstName} ${userDetails.lastName}',
                // userNameColor: userNameColor,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.04, horizontal: 12),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    DefaultTextTile(
                      convController: convController,
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.minHeight,
                    maxHeight: Get.height * 0.2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: AudioButtons(
                        convController: convController,
                        mealInputController: mealController,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ConvScreenAppBar extends StatelessWidget {
  const ConvScreenAppBar({
    super.key,
    required this.userName,
  });

  final String userName;
  // final Color userNameColor;

  //function to show greeting message according to the time
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        onPressed: () {
          Get.toNamed('/profile', arguments: []);
        },
        icon: Hero(
          tag: 'profileImage',
          child: CircleAvatar(
            // backgroundColor: Colors.purpleAccent,
            child: userName.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 30,
                  )
                : Text(userName.substring(0, 1).toUpperCase(),
                    style: TextStyles.titles
                        .copyWith(color: Colors.black, fontSize: 24)),
          ),
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: SvgPicture.asset('assets/images/profile/notifications.svg'),
      //   ),
      // ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getGreeting(), style: TextStyles.headLine2),
          Text(
            userName,
            style: TextStyles.textFieldHintText,
          )
        ],
      ),
    );
  }
}
