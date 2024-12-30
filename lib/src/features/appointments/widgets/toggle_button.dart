// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';

class ToggleButton extends StatelessWidget {
  final String firstOption;
  final String secondOption;
  final List<bool> isSelected;
  final Function(int) onPressed;

  const ToggleButton({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints.expand(
            width: Get.width * 0.45, height: Get.height * 0.035),
        fillColor: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
        isSelected: isSelected,
        onPressed: onPressed,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Center(
              child: Text(
                firstOption,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Center(
              child: Text(
                secondOption,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
