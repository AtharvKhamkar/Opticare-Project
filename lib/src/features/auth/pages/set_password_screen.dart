import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_input_field.dart';
import 'package:vizzhy/src/features/auth/widgets/password_criteria_widget.dart';

///Hardcoded screen for SetPassword
class SetPasswordScreen extends StatefulWidget {
  ///Constructor of the SetPassword Screen
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  var setPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Padding(
        padding:
            EdgeInsets.symmetric(vertical: Get.height * 0.05, horizontal: 12),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: setPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
                    child:
                        const Text("Set Password,", style: TextStyles.titles),
                  ),
                  SizedBox(
                    height: Get.height * 0.001,
                  ),
                  Obx(
                    () => CustomInputField2(
                        controller: controller.userNameController,
                        inputType: TextInputType.emailAddress,
                        label: "Create New Password",
                        hintText: "New Password",
                        validator: (value) =>
                            AppValidatorUtil.validateEmail(value),
                        prefixIcon: null,
                        errorMessage: controller.errorEmailMessage.value,
                        listOfAutofill: const [AutofillHints.email]),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Obx(
                    () => CustomInputField2(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.passwordController,
                      inputType: TextInputType.visiblePassword,
                      hintText: "Confirm Password",
                      label: "Confirm New Password",
                      onChanged: (c) {},
                      formatter: [
                        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                      ],
                      validator: (value) => AppValidatorUtil.validateEmpty(
                          value: value, message: 'Password'),
                      errorMessage: controller.errorPasswordMessage.value,
                      listOfAutofill: const [AutofillHints.password],
                      suffixIcon: true,
                      isDense: true,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const PasswordCriteriaWidget(),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const SizedBox.shrink(),
                  CustomFormButton(
                    innerText: "Set Password",
                    onPressed: () {
                      AppDialogHandler.successBottomSheet(
                        onClose: () {
                          Get.offNamed('/mpin-setup');
                        },
                      );
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
