// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/success_message.dart';

class SetPasswordSuccessScreen extends StatefulWidget {
  final String redirectScreenPath;

  const SetPasswordSuccessScreen({
    super.key,
    required this.redirectScreenPath,
  });

  @override
  State<SetPasswordSuccessScreen> createState() =>
      _SetPasswordSuccessScreenState();
}

class _SetPasswordSuccessScreenState extends State<SetPasswordSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(widget.redirectScreenPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SuccessMessage(
      assetPath: 'assets/images/profile/successLogo.png',
      successMessage: 'Password Set Successful',
    );
  }
}
