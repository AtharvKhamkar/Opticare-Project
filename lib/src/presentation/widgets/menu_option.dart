// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';

class MenuOption extends StatelessWidget {
  final String? assetPath;
  final String title;
  final bool isLeadingIcon;
  final Future<void> Function() onClick;
  final bool showDivider;
  final Color? iconColor;

  const MenuOption(
      {super.key,
      this.assetPath,
      required this.title,
      this.isLeadingIcon = true,
      required this.onClick,
      this.showDivider = true,
      this.iconColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    final getWidth = Get.width;
    final getHeight = Get.height;
    final screenWidth = getWidth > Get.height ? getHeight : getWidth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        width: getWidth <= 360 ? 70 : 90,
        child: Column(
          children: [
            GestureDetector(
              onTap: onClick,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors
                          .primaryColor, // You can change the color as per your need
                      width: 0.5, // Top border width
                    ),
                    left: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.0, // Left border width
                    ),
                    right: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.0, // Right border width
                    ),
                    bottom: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2, // Bottom border width
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: assetPath != null
                      ? SvgPicture.asset(
                          assetPath!,
                          height: screenWidth <= 360
                              ? screenWidth * 0.08
                              : screenWidth * 0.1,
                          width: screenWidth * 0.1,
                          // color: iconColor,
                          colorFilter: ColorFilter.mode(
                              iconColor ?? AppColors.primaryColor,
                              BlendMode.srcIn),
                        )
                      : const SizedBox(
                          height: 40,
                          width: 40,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyles.defaultText.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
