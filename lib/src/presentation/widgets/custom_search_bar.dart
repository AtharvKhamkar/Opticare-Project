import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///This is custome search bar widget used on chat_history_screen
class CustomSearchBar extends StatelessWidget {
  ///Constructor
  const CustomSearchBar({
    super.key,
    required this.controller,
  });

  ///Need pass TextEditingController
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: false,
      style: TextStyles.headLine2,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          hintText: 'Search',
          hintStyle: TextStyles.headLine3,
          fillColor: AppColors.tileBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey.shade600,
            size: 24,
          )),
      maxLines: null,
      textInputAction: TextInputAction.done,
      autofocus: false,
      onTap: () {},
    );
  }
}
