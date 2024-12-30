import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/global/app_config_dev.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/features/support/presentation/widgets/security_options.dart';
import 'package:vizzhy/src/utils/app_util.dart';

///This is a Hardcoded screen for Help & Support
class HelpSupportPage extends StatelessWidget {
  ///Constructor of the HelpSupportPage
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "Help"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            SecurityOption(
                title: 'FAQ',
                onTap: () {
                  AppUtil().launchURL(AppConfigDev().faqUrl);
                }),
            // SecurityOption(title: 'Technical Support', onTap: () {})
          ],
        ),
      ),
    );
  }
}
