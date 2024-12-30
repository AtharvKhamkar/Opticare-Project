// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///This widget is used to show custome bottom sheet
class CustomBottomSheetButton extends StatelessWidget {
  final Function()? onTap;
  final String assetPath;
  final String subtitle;
  final double size;
  final double padding;
  final double fontSize;
  final bool isLoading;
  const CustomBottomSheetButton(
      {super.key,
      this.onTap,
      required this.assetPath,
      required this.subtitle,
      this.size = 60,
      this.padding = 16,
      this.isLoading = false,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.sheetButtonBgColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(200),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : SvgPicture.asset(
                      assetPath,
                      // color: Colors.white,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),

                      height: size,
                      width: size,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          subtitle,
          style: TextStyles.headLine2
              .copyWith(fontWeight: FontWeight.w400, fontSize: fontSize),
        )
      ],
    );
  }
}
