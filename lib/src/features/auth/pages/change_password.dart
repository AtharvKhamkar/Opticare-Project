import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_input_field.dart';

///Hardcoded screen for change password
class ChangePassword extends StatefulWidget {
  ///contructor of the change password
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var changePasswordKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.darkBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: 'Change Password'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Form(
              key: changePasswordKey,
              child: Column(
                children: [
                  Obx(
                    () => CustomInputField2(
                      controller: currentPasswordController,
                      inputType: TextInputType.visiblePassword,
                      hintText: 'Enter Current Password',
                      label: 'Current Password',
                      validator: (value) => AppValidatorUtil.validateEmpty(
                          value: value, message: 'Password'),
                      errorMessage: controller.errorPasswordMessage.value,
                      listOfAutofill: const [AutofillHints.password],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Obx(
                    () => CustomInputField2(
                        controller: newPasswordController,
                        inputType: TextInputType.visiblePassword,
                        hintText: 'Enter Password',
                        label: 'New Password',
                        validator: (value) => AppValidatorUtil.validateEmpty(
                            value: value, message: 'Password'),
                        errorMessage: controller.errorPasswordMessage.value,
                        listOfAutofill: const [AutofillHints.password],
                        suffixIcon: true,
                        isDense: true,
                        obscureText: true),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Obx(
                    () => CustomInputField2(
                        controller: confirmPasswordController,
                        inputType: TextInputType.visiblePassword,
                        hintText: 'Confirm Password',
                        label: 'Confirm New Password',
                        validator: (value) => AppValidatorUtil.validateEmpty(
                            value: value, message: 'Password'),
                        errorMessage: controller.errorPasswordMessage.value,
                        listOfAutofill: const [AutofillHints.password],
                        suffixIcon: true,
                        isDense: true,
                        obscureText: true),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  const Text(
                    '(e.g., minimum 8 characters, at least one uppercase letter, one number, and one special character)',
                    style: TextStyles.textFieldTitles,
                  ),
                  SizedBox(
                    height: Get.height * 0.3,
                  ),
                  CustomFormButton(
                      innerText: 'Update Password', onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
