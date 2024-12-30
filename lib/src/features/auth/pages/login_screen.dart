import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/core/global/app_config_dev.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_input_field.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/utils/app_util.dart';

///This screen is used to authenticate user using username and password
class LoginScreen extends StatefulWidget {
  ///constructor of the login screen
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 30),
                    decoration: BoxDecoration(
                      color: AppColors.blueColorDark.withOpacity(0.9),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('User Login',
                            style: TextStyles.headLine2_Bold),
                        Obx(
                          () => CustomInputField2(
                              controller: controller.userNameController,
                              inputType: TextInputType.emailAddress,
                              label: "User Name",
                              hintText: "Enter Email",
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
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.passwordController,
                            inputType: TextInputType.visiblePassword,
                            hintText: "Enter Password",
                            label: "Password",
                            onChanged: (c) {},
                            formatter: [
                              FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                            ],
                            validator: (value) =>
                                AppValidatorUtil.validateEmpty(
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
                        CustomFormButton(
                          innerText: "Login",
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              AppStorage.saveUserCredentials(
                                  controller.userNameController.value.text,
                                  controller.passwordController.value.text);
                              controller.login();
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const Text(
                          "Forgot your password ?",
                          style: TextStyles.defaultText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Terms of use',
                          style: TextStyles.purpleText,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 15, // Adjust the height as needed
                        width: 1, // This acts like the thickness of the Divider
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyles.purpleText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
