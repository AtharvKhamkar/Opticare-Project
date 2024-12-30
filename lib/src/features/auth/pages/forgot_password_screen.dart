import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_input_field.dart';

///Hardcoded screen for forgot password
class ForgotPasswordScreen extends StatelessWidget {
  ///TextEditingController is used handle mobile number field text
  final TextEditingController mobileNumberController = TextEditingController();

  ///TextEditingController is used email field text
  final TextEditingController emailController = TextEditingController();

  ///Constructor of the forgot password screen
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Forgot Password'),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 48),
            child: Column(
              children: [
                const Text(
                  'To reset your password confirm your registered mobile number and email address',
                  style: TextStyles.headLine2,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                CustomInputField2(
                  controller: controller.forgotPasswordController,
                  inputType: TextInputType.emailAddress,
                  label: "Email Address",
                  hintText: "Enter Email Address",
                  validator: (value) => AppValidatorUtil.validateEmail(value),
                  prefixIcon: null,
                  errorMessage: '',
                  listOfAutofill: const [AutofillHints.email],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                const Text(
                  'A 4-digit OTP will be sent to your email address',
                  style: TextStyles.headLine3,
                ),
                const Spacer(),
                CustomFormButton(
                  innerText: "Get OTP",
                  onPressed: () {
                    controller.forgotPassword();
                    Get.toNamed('/otp-verification');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
