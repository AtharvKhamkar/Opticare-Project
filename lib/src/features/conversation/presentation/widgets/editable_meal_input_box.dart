import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

import '../../../../core/constants/constants.dart';

///
/// contains text editing feature
/// as well as ASR
class MealInputBox extends StatelessWidget {
  /// whether this textfield is editable by user
  /// or not
  final bool isEditable;

  /// controller for textfield
  final TextEditingController textController;

  /// GetxController for conversation
  final ConversationController controller;

  /// hint Text in the textfiled
  final String? hintText;

  /// suffix icon
  /// Audio button
  final Widget suffix;

  ///
  final PdfController pdfController =
      PdfController().initialized ? Get.find() : Get.put(PdfController());

  /// contructor
  /// isEditable (required)
  /// textController (reequired)
  /// hintText (optional) default value is Empty
  /// controller (required)
  /// suffix for Audio button
  MealInputBox({
    super.key,
    required this.isEditable,
    required this.textController,
    this.hintText = '',
    required this.controller,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.015,
        horizontal: 10,
      ),
      padding: const EdgeInsets.only(left: 10),
      // margin: EdgeInsets.only(
      //     top: Get.height * 0.015,
      //     bottom: Get.height * 0.015,
      //     left: 2,
      //     right: 10),
      // padding: EdgeInsets.only(
      //     top: Get.height * 0.006,
      //     bottom: Get.height * 0.006,
      //     left: 10,
      //     right: 60),
      // decoration: BoxDecoration(
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(50),
      //   ),
      //   border: Border.all(width: 2, color: AppColors.primaryColor),
      //   color: Colors.transparent,
      // ),
      child: TextField(
        controller: textController,
        readOnly: !isEditable,
        style: TextStyles.headLine2,
        decoration: InputDecoration(
          suffixIcon: suffix,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2)),
          isDense: true,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 32,
            minWidth: 32,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: hintText,
          hintStyle: TextStyles.headLine2.copyWith(color: Colors.grey),
          prefixIcon: IconButton(
            onPressed: () {
              AppDialogHandler.uploadFilesBottomSheet(
                  controller: pdfController,
                  onPdfClick: () async {
                    debugPrint('Pdf file upload clicked ');
                    await pdfController.uploadPdf();
                    Get.back();
                  },
                  onGalleryClick: () {
                    debugPrint('Gallery upload clicked');
                    CustomToastUtil.showFailureToast(message: 'Coming soon...');
                  },
                  onCameraClick: () {
                    debugPrint('Camera upload clicked');
                    CustomToastUtil.showFailureToast(message: 'Coming soon...');
                  });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        maxLines: null,
        textInputAction: TextInputAction.done,
        autofocus: false,
      ),
    );
  }
}
