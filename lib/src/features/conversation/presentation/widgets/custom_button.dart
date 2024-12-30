// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String path;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: SvgPicture.asset(path),
      label: Text(
        text,
        style: TextStyles.headLine2,
      ),
      iconAlignment: IconAlignment.end,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Background color
        iconColor: Colors.white, // Text and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
