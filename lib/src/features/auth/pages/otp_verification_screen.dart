import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_pinput.dart';

///Hardcoded screen for OTP verification
class OtpVerificationScreen extends StatelessWidget {
  ///TextEditingController used to handle Email field
  final TextEditingController emailOtpController = TextEditingController();

  ///TextEditingController used to handle mobile otp field.
  final TextEditingController mobileOtpController = TextEditingController();

  ///Constructor of the OtpVarificationScreen
  OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Authenticate'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Get.height * 0.04, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please fill in the one time password sent on \n email and mobile.',
                style: TextStyles.headLine3,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text(
                'Email Verification Code',
                style: TextStyles.headLine1,
              ),
              CustomPinput(controller: emailOtpController, length: 4),
              const Text(
                'Enter the 4-digit verification code sent to ch**********@gmail.com',
                style: TextStyles.headLine3,
              ),
              SizedBox(height: Get.height * 0.05),
              const Text(
                'Mobile Verification Code',
                style: TextStyles.headLine1,
              ),
              CustomPinput(controller: mobileOtpController, length: 4),
              const Text(
                'Enter the 4-digit verification code sent to\n+91 98*******16',
                style: TextStyles.headLine3,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text.rich(
                TextSpan(
                  text: 'You can request a new code in ',
                  style: TextStyles.defaultText,
                  children: [
                    TextSpan(
                      text: '15 seconds',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.primaryColor),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'RESEND CODE',
                style: TextStyles.headLine3,
              ),
              SizedBox(
                height: Get.height * 0.09,
              ),
              CustomFormButton(
                innerText: 'Continue',
                onPressed: () {
                  AppDialogHandler.successBottomSheet(
                    onClose: () {
                      Get.offNamed('/set-password');
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
