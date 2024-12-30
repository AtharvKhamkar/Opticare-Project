// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? backButton;
  final List<Widget>? actionWidgets;
  const CustomAppBar(
      {super.key, required this.title, this.backButton, this.actionWidgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ElevatedButton(
        onPressed: backButton ??
            () {
              Get.back();
            },
        style: const ButtonStyle(
          backgroundColor: WidgetStateColor.transparent,
        ),
        iconAlignment: IconAlignment.start,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(title, style: TextStyles.appBarTitle),
      actions: actionWidgets,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
