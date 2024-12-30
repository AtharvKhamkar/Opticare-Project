import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/features/auth/widgets/custom_pinput.dart';

///Hardcoded for mpin setup
class MpinSetupScreen extends StatefulWidget {
  ///contructor of the MpinSetupScreen
  const MpinSetupScreen({super.key});

  @override
  State<MpinSetupScreen> createState() => _MpinSetupScreenState();
}

class _MpinSetupScreenState extends State<MpinSetupScreen> {
  TextEditingController mpinController = TextEditingController();

  bool faceIdSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: Get.height * 0.15,
              bottom: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Setup MPIN',
                style: TextStyles.titles,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text.rich(
                TextSpan(
                  text: 'To setup ',
                  style: TextStyles.headLine3,
                  children: [
                    TextSpan(text: 'MPIN ', style: TextStyles.defaultText),
                    TextSpan(text: 'create a ', style: TextStyles.headLine3),
                    TextSpan(
                        text: '4 digit code', style: TextStyles.defaultText)
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              const Text(
                'Enter MPIN',
                style: TextStyles.textFieldHintText,
              ),
              CustomPinput(controller: mpinController, length: 4),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Text(
                'Confirm MPIN',
                style: TextStyles.textFieldHintText,
              ),
              CustomPinput(controller: mpinController, length: 4),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Enable Face ID',
                    style: TextStyles.headLine2,
                  ),
                  CupertinoSwitch(
                    value: faceIdSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        faceIdSwitch = value;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.17,
              ),
              CustomFormButton(
                innerText: 'Continue',
                onPressed: () {
                  AppDialogHandler.successBottomSheet(
                    onClose: () {
                      Get.offAllNamed('/conversation');
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
