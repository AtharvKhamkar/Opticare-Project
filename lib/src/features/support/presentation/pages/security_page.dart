import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/global/app_config_dev.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/utils/app_util.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/features/support/presentation/widgets/security_options.dart';

///This screen is used to change password, Display Terms of use and Privacy Policy
class SecurityPage extends StatelessWidget {
  ///Constructor of the Security Page
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: 'Security'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
            // SecurityOption(
            //     title: 'Change Password',
            //     onTap: () {
            //       Get.toNamed('/change-password');
            //     }),
            SecurityOption(
                title: 'Terms of Use',
                onTap: () {
                  AppUtil().launchURL(AppConfigDev().termsCondition);
                }),
            SecurityOption(
                title: 'Privacy policy',
                onTap: () {
                  AppUtil().launchURL(AppConfigDev().termsCondition);
                }),
            const Spacer(),
            GestureDetector(
              onTap: () {
                AppDialogHandler.deleteAccountBottomSheet();
              },
              child: Text(
                'Delete Account',
                style: TextStyles.errorAlertText.copyWith(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
