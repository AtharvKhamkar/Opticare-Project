// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///Widget used to success message
class SuccessMessage extends StatefulWidget {
  final String assetPath;
  final String successMessage;
  final double size;

  const SuccessMessage({
    super.key,
    required this.assetPath,
    required this.successMessage,
    this.size = 138,
  });

  @override
  State<SuccessMessage> createState() => _SuccessMessageState();
}

class _SuccessMessageState extends State<SuccessMessage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.assetPath,
              height: widget.size,
              width: widget.size,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Text(widget.successMessage,
                    textAlign: TextAlign.center, style: TextStyles.headLine1))
          ],
        ),
      ),
    );
  }
}
