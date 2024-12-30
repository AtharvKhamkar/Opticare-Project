// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///This is custom widget for Pinput which is used while entering OTP pins
class CustomPinput extends StatelessWidget {
  final TextEditingController controller;
  final int length;
  final double? size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final bool? isObsecure;

  const CustomPinput({
    super.key,
    required this.controller,
    required this.length,
    this.size,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.borderRadius,
    this.isObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: length,
      obscureText: isObsecure ?? true,
      defaultPinTheme: buildDefaultPinTheme(),
    );
  }

  PinTheme buildDefaultPinTheme() {
    return PinTheme(
      width: size ?? 60,
      height: size ?? 60,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
      textStyle: TextStyles.textFieldHintText,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor ?? Colors.grey.shade700),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
    );
  }
}
