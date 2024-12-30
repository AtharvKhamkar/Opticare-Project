import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/success_message.dart';

///Hardcoded screen after successfully entering OTP
class OtpSuccessScreen extends StatefulWidget {
  ///Need to pass redirection path after successfull message user is redirected to this route
  final String redirectScreenPath;

  ///constructor of the OtpSuccessScreen
  const OtpSuccessScreen({
    super.key,
    required this.redirectScreenPath,
  });

  @override
  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen> {
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
      successMessage: 'OTP Verification Successful',
    );
  }
}
