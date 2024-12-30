// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
// import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
// import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
// import 'package:vizzhy/src/features/conversation/presentation/models/meal_input_model.dart';
// import 'package:vizzhy/src/features/conversation/presentation/widgets/default_thanks_box.dart';
// import 'package:vizzhy/src/features/conversation/presentation/widgets/default_welcome_box.dart';
// import 'package:vizzhy/src/features/conversation/presentation/widgets/meal_input_box.dart';

// import '../controller/conversation_controller.dart';
// import '../controller/meal_input_controller.dart';

// class LogFood extends StatefulWidget {
//   const LogFood({super.key});

//   @override
//   State<LogFood> createState() => _LogFoodState();
// }

// class _LogFoodState extends State<LogFood> {
//   final MealInputController controller = MealInputController().initialized
//       ? Get.find()
//       : Get.put(MealInputController());
//   final ConversationController conversationController =
//       Get.find<ConversationController>();

//   @override
//   void initState() {
//     super.initState();

//     // Scroll to the bottom when the page is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(const Duration(milliseconds: 300), () {
//         controller.scrollToBottom();
//       });
//     });

//     // Optional: Scroll to the bottom when new data is added
//     controller.mealInputs.listen((_) {
//       Future.delayed(const Duration(milliseconds: 300), () {
//         controller.scrollToBottom();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: const CustomAppBar(title: "Log Food"),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//         child: Column(
//           children: [
//             // RecentMealLogs(controller: controller),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 mealInputBox(
//                     conversationController: conversationController,
//                     textEditingController: controller.textEditingController),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 SendMealButton(
//                     conversationController: conversationController,
//                     textEditingController: controller.textEditingController,
//                     controller: controller)
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //This widget logs recent meals and return success response
// // class RecentMealLogs extends StatelessWidget {
// //   const RecentMealLogs({
// //     super.key,
// //     required this.controller,
// //   });

// //   final MealInputController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: Obx(
// //         () {
// //           if (controller.isLoading.value) {
// //             return const Center(
// //                 child: CircularProgressIndicator(
// //               backgroundColor: Colors.white,
// //             ));
// //           }
// //           return ListView.builder(
// //             controller: controller.scrollController,
// //             itemCount: controller.mealInputs.length + 1,
// //             itemBuilder: (context, index) {
// //               if (index == 0) {
// //                 return const DefaultWelcomeBox();
// //               }
// //               MealInput mealInput = controller.mealInputs[index - 1];
// //               return Column(
// //                 children: [
// //                   MealInputBox(
// //                     text: mealInput.mealInput,
// //                     time: DateFormat('hh:mm a').format(
// //                       mealInput.createdAt.toLocal(),
// //                     ),
// //                   ),
// //                   const DefaultThanksBox(),
// //                 ],
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// //This widget is used to enter meals.
// class mealInputBox extends StatelessWidget {
//   const mealInputBox({
//     super.key,
//     required this.conversationController,
//     required this.textEditingController,
//   });

//   final ConversationController conversationController;
//   final TextEditingController textEditingController;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Obx(() {
//         if (conversationController.isListening.value) {
//           return SizedBox(
//             height: Get.height * 0.1,
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.grayTileColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Lottie.asset('assets/animations/wave_animation.json',
//                     fit: BoxFit.fill),
//               ),
//             ),
//           );
//         } else if (conversationController.recognizedText.value.isNotEmpty) {
//           textEditingController.text =
//               conversationController.recognizedText.value;
//           return SizedBox(
//             height: Get.height * 0.1,
//             child: Center(
//               child: TextField(
//                 controller: textEditingController,
//                 style: TextStyles.ButtonText,
//                 decoration: InputDecoration(
//                     hintStyle: TextStyles.textFieldHintText,
//                     filled: true,
//                     fillColor: AppColors.grayTileColor,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 16)),
//               ),
//             ),
//           );
//         } else {
//           return SizedBox(
//             height: Get.height * 0.1,
//             child: Center(
//               child: TextField(
//                 controller: textEditingController,
//                 style: TextStyles.ButtonText,
//                 decoration: InputDecoration(
//                     hintText: "Write your message",
//                     hintStyle: TextStyles.textFieldHintText,
//                     filled: true,
//                     fillColor: AppColors.grayTileColor,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 16)),
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }
// }

// class SendMealButton extends StatelessWidget {
//   const SendMealButton({
//     super.key,
//     required this.conversationController,
//     required this.textEditingController,
//     required this.controller,
//   });

//   final ConversationController conversationController;
//   final TextEditingController textEditingController;
//   final MealInputController controller;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Obx(() {
//         if (conversationController.isListening.value) {
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.all(4),
//             child: SvgPicture.asset(
//               "assets/images/profile/stopMic.svg",
//               height: 32,
//               width: 32,
//             ),
//           );
//         } else if (!controller.isTextFieldEmpty.value) {
//           return InkWell(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.all(4),
//               child: SvgPicture.asset("assets/images/profile/sendIcon.svg",
//                   height: 24, width: 24),
//             ),
//             onTap: () {
//               String inputText = textEditingController.text;
//               if (inputText.isNotEmpty) {
//                 controller.postMealInput(inputText);
//                 textEditingController.clear();
//                 conversationController.recognizedText.value = '';
//               }
//             },
//           );
//         } else {
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.all(4),
//             child: SvgPicture.asset(
//               "assets/images/profile/mic.svg",
//               height: 32,
//               width: 32,
//             ),
//           );
//         }
//       }),
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         if (conversationController.isListening.value) {
//           conversationController.stopListening();
//         } else {
//           conversationController.startListening();
//         }
//       },
//     );
//   }
// }
