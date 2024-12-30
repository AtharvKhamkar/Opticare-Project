// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color backgroundColor;
  final Color borderColor;
  final double height;
  final bool isOutlined;
  final bool isLoading;
  final bool isEnable;
  final Widget? icon;
  final double? borderRadius;
  final double width;

  const CustomFormButton({
    super.key,
    required this.innerText,
    required this.onPressed,
    this.horizontalPadding = 20,
    this.verticalPadding = 12,
    this.backgroundColor = AppColors.primaryColor,
    this.borderColor = AppColors.primaryColor,
    this.height = 48,
    this.width = double.infinity,
    this.isOutlined = false,
    this.isLoading = false,
    this.isEnable = true,
    this.icon,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 0,
              horizontal: horizontalPadding ?? 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 14),
          ),
          side: BorderSide(color: borderColor, width: 1),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : Center(
                child: Text(
                  innerText,
                  style: TextStyles.headLine2,
                ),
              ),
      ),
    );
  }
}
