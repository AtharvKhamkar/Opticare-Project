import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This is hardcoded screen for caregiver support need to implement later
class CaregiverSupportPage extends StatelessWidget {
  ///constructor of the CaregiverSupportPage
  const CaregiverSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: CustomAppBar(title: 'Caregiver Support'),
      body: Center(
        child: Text(
          'Coming Soon...',
          style: TextStyles.headLine1,
        ),
      ),
    );
  }
}
