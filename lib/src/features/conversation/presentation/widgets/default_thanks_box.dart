import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';

class DefaultThanksBox extends StatelessWidget {
  const DefaultThanksBox({super.key});

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
            color: const Color(0x285f5771)
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Color(0x3d4238d2), Color(0x16a83062), Color(0x05c159e)],
            //   stops: [0.3, 1.0, 0.8],
            // ),
            ),
        child: const Center(
          child: Text(
            "Thanks for logging your food.",
            style: TextStyles.headLine2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
