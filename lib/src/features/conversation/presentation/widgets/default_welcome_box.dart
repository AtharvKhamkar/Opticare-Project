import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';

import '../../../../core/constants/constants.dart';

class DefaultWelcomeBox extends StatefulWidget {
  const DefaultWelcomeBox({super.key});

  @override
  State<DefaultWelcomeBox> createState() => _DefaultWelcomeBoxState();
}

class _DefaultWelcomeBoxState extends State<DefaultWelcomeBox> {
  final userDetails = AppStorage.getUserLoginDetails();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: Get.height * 0.1,
        width: Get.width * 0.75,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(0),
            ),
            border: Border.all(width: 1, color: Colors.transparent),
            color: const Color(0x285f5771)),
        child: Center(
          child: Text(
            'Good morning, ${userDetails.firstName}. What did you eat?',
            style: TextStyles.headLine2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
