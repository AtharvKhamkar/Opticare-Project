import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';
import 'package:vizzhy/src/presentation/widgets/custom_alert_dialog.dart';
import 'package:vizzhy/src/presentation/widgets/custom_bottom_sheet_button.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';

import '../constants/Colors/app_colors.dart';
import '../constants/fonts/text_styles.dart';

///This class contains widgets for the all the Dialogs used in the application
class AppDialogHandler {
  ///Dialog to display customer dont have acess to respective feature
  static void accessDeniedDialog({Function()? retry}) {
    Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            child: CustomAlertDialog(
                assetPath: 'assets/images/profile/lock.svg',
                title: 'Access Denied',
                alertMessage:
                    'Your account access is restricted. Please contact the admin for assistance.',
                buttonText: 'Ok',
                retryPressed: retry,
                onPressed: () {
                  Get.back();
                }),
          ),
        ),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut);
  }

  ///This Dialog is showned after the success scenarios
  static void successBottomSheet({required Function onClose}) async {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.4,
        decoration: BoxDecoration(
          color: AppColors.bottomSheetColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: PopScope(
          canPop: false,
          child: Center(
            child: CircleAvatar(
              radius: 74,
              backgroundColor: AppColors.tileBackgroundColor,
              child: SvgPicture.asset(
                'assets/images/profile/successLogo.svg',
                height: 50,
                width: 50,
              ),
            ),
          ),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );

    await Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.back();
        onClose();
      },
    );
  }

  //symmetric(horizontal: 28, vertical: 35),

  ///BottomSheet is used confirm whether customer want to logout or not
  static void logoutBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      padding: const EdgeInsets.only(left: 28, right: 28, top: 35),
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Are you sure you want to log out?',
              style: TextStyles.headLine3
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomFormButton(
              borderRadius: 32,
              innerText: 'Yes, log me out',
              onPressed: () {
                AppStorage.logout();
                Get.back();
              },
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            CustomFormButton(
              borderRadius: 32,
              innerText: 'No, keep me signed in',
              onPressed: () {
                Get.back();
              },
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    ));
  }

  ///Confirmation bottomsheet to confirm whether customer want to delete account or not
  static void deleteAccountBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      padding: const EdgeInsets.only(left: 28, right: 28, top: 35),
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Are you sure you want to delete?',
              style: TextStyles.headLine3
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomFormButton(
              borderRadius: 16,
              innerText: 'Yes',
              onPressed: () {
                deleteAccountDialog();
              },
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            CustomFormButton(
              borderRadius: 16,
              innerText: 'No',
              onPressed: () {
                Get.back();
              },
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    ));
  }

  ///Confirmation Dialog to confirm whether customer want to delete account or not
  static void deleteAccountDialog() {
    Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            child: CustomAlertDialog(
                assetPath: 'assets/images/profile/delete_account.svg',
                title: 'Account Deletion Request',
                alertMessage:
                    'Your request has been received. Our caregiver/admin will contact you shortly to assist with the deletion process.',
                buttonText: 'Ok',
                onPressed: () {
                  Get.back();
                }),
          ),
        ),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut);
  }

  ///Confirmation bottomsheet to choose between customer want to use ASR functionality or VizzhyAI functionality
  static void showChooseAsrDialog(
      {required Function()? onVizzhyAiClick, required Function()? onAsrClick}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.3,
        padding: const EdgeInsets.only(left: 28, right: 28, top: 10),
        decoration: const BoxDecoration(
          color: AppColors.appointmentTileColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 5,
              width: Get.width * 0.15,
              decoration: const BoxDecoration(
                color: AppColors.grayAppointmentTileColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBottomSheetButton(
                  assetPath: 'assets/images/profile/vizzhy_ai_bot.svg',
                  subtitle: 'Ask Anything',
                  onTap: onVizzhyAiClick,
                  fontSize: 18,
                ),
                CustomBottomSheetButton(
                  onTap: onAsrClick,
                  assetPath: 'assets/images/profile/asr.svg',
                  subtitle: 'Food Log',
                  fontSize: 18,
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  ///This Bottomsheet is used while customer want upload external reports in pdf, image or capturing photo format
  static void uploadFilesBottomSheet({
    required Function()? onPdfClick,
    required Function()? onGalleryClick,
    required Function()? onCameraClick,
    required PdfController controller,
  }) {
    final double height = Get.height;
    final double width = Get.width;

    Get.bottomSheet(Container(
      height: height * 0.3,
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width * 0.07),
          topRight: Radius.circular(width * 0.07),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.006,
            width: width * 0.15,
            decoration: BoxDecoration(
              color: AppColors.grayAppointmentTileColor,
              borderRadius: BorderRadius.all(
                Radius.circular(width * 0.03),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                return CustomBottomSheetButton(
                  assetPath: 'assets/images/profile/file.svg',
                  subtitle: controller.isLoading.value
                      ? 'Uploading...'
                      : 'Upload File',
                  onTap: onPdfClick,
                  size: width * 0.1, // Button size based on screen width
                  padding:
                      width * 0.06, // Padding as percentage of screen width
                  fontSize: width * 0.04, // Font size based on screen width
                  isLoading: controller.isLoading.value,
                );
              }),
              CustomBottomSheetButton(
                onTap: onGalleryClick,
                assetPath: 'assets/images/profile/photo_library.svg',
                subtitle: 'Upload Photo',
                size: width * 0.1,
                padding: width * 0.06,
                fontSize: width * 0.04,
              ),
              CustomBottomSheetButton(
                onTap: onCameraClick,
                assetPath: 'assets/images/profile/photo_camera.svg',
                subtitle: 'Take A Photo',
                size: width * 0.1,
                padding: width * 0.06,
                fontSize: width * 0.04,
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    ));
  }

  ///This widget created to use customizable bottomsheet
  static void customBottomSheet({
    required String message,
    required String cancelMessage,
    required String confirmActionMessage,
    required Function()? onConfirmFunction,
    required Function()? onCancelFunction,
  }) {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      padding: const EdgeInsets.only(left: 28, right: 28, top: 35),
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              message,
              style: TextStyles.headLine3
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomFormButton(
                borderRadius: 16,
                innerText: confirmActionMessage,
                onPressed: onConfirmFunction),
            SizedBox(
              height: Get.height * 0.025,
            ),
            CustomFormButton(
              borderRadius: 16,
              innerText: cancelMessage,
              onPressed: onCancelFunction,
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    ));
  }

  ///This bottomsheet is used to add quantity of the meal
  static void addMealQuantityBottomSheet({
    required String meal,
    required Function()? onSaveFunction,
    required Function()? onEditFunction,
  }) {
    Get.bottomSheet(Container(
      height: Get.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.darkTileColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$meal more foods added',
                style:
                    TextStyles.headLine2.copyWith(fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Text(
                  'Undo',
                  style: TextStyles.purpleText,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomFormButton(
                    borderRadius: 16,
                    innerText: 'Edit',
                    backgroundColor: AppColors.darkTileColor,
                    onPressed: onEditFunction),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Expanded(
                child: CustomFormButton(
                    borderRadius: 16,
                    innerText: 'Save',
                    onPressed: onSaveFunction),
              )
            ],
          )
        ],
      ),
    ));
  }

  ///This dialog is used after successfull updation or addition of the meal
  static Future<void> mealUploadSuccessDialog(
      {required String successMessage}) async {
    Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
              child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: AppColors.grayTileColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/profile/check_circle.svg'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    successMessage,
                    style: TextStyles.headLine2.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          )),
        ),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut);

    await Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // Closes the dialog
    });
  }
}
