import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This is a hardcoded screen for the TechnicalSupport Page used to display Technical Support email and phone number
class TechnicalSupportPage extends StatelessWidget {
  ///Constructor of the TechnicalSupportPage
  const TechnicalSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Technical Support'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_technicalSupportOptions()],
        ),
      ),
    );
  }

  Widget _technicalSupportOptions() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors
            .tileBackgroundColor, // Apply background color with opacity
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildTechnicalSupportOptions('Email', 'Email123@vizzhy.com'),
          _buildTechnicalSupportOptions('Contact No', '91+9876543210',
              showDivider: false)
        ],
      ),
    );
  }

  Widget _buildTechnicalSupportOptions(String title, String subtitle,
      {bool showDivider = true}) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          ListTile(
              minVerticalPadding: 0,
              title: Text(title, style: TextStyles.headLine2),
              onTap: () {},
              trailing: Text(
                subtitle,
                style: TextStyles.headLine3,
              )),
          if (showDivider)
            const Divider(
              thickness: 0.1,
            )
        ],
      ),
    );
  }
}
