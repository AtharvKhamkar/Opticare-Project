// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';

import 'package:vizzhy/src/core/constants/constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String assetPath;
  final String title;
  final String alertMessage;
  final String buttonText;
  final Function() onPressed;
  final Function()? retryPressed;

  const CustomAlertDialog({
    super.key,
    required this.assetPath,
    required this.title,
    required this.alertMessage,
    required this.buttonText,
    required this.onPressed,
    this.retryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      decoration: const BoxDecoration(
        color: AppColors.primaryColorDark,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(assetPath),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                title,
                style: TextStyles.errorAlertText,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                '"$alertMessage"',
                style: TextStyles.defaultText.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              SizedBox(
                width: Get.width * 0.25,
                child: CustomFormButton(
                    innerText: buttonText, onPressed: onPressed),
              ),
              const SizedBox(
                height: 10,
              ),
              if (retryPressed != null)
                SizedBox(
                  width: Get.width * 0.25,
                  child: CustomFormButton(
                      innerText: 'Retry', onPressed: retryPressed),
                )
            ],
          ),
        ),
      ),
    );
  }
}
