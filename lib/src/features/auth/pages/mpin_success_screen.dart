import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/success_message.dart';

///Hardcoded screen after successfully entering Mpin
class MpinSuccessScreen extends StatefulWidget {
  ///redirection url need to be passed wher customer is redirected after success message
  final String redirectScreenPath;

  ///Constructor of the MpinSuccessScreen
  const MpinSuccessScreen({
    super.key,
    required this.redirectScreenPath,
  });

  @override
  State<MpinSuccessScreen> createState() => _MpinSuccessScreenState();
}

class _MpinSuccessScreenState extends State<MpinSuccessScreen> {
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
      successMessage: 'MPIN Registration Successful',
    );
  }
}
