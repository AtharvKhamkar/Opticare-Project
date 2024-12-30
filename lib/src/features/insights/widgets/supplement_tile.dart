// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///Widget to display single supplement
// ignore: camel_case_types
class supplementTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String period;

  const supplementTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                title,
                style: TextStyles.headLine2,
              ),
              subtitle: Text(
                subtitle,
                style: TextStyles.appBarTitle,
              ),
              trailing:
                  SvgPicture.asset('assets/images/profile/supplement.svg'),
            ),
          ),
          const Divider(
            thickness: 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: AppColors.primaryColorLight)),
                child: Center(
                  child: Text(
                    period,
                    style: TextStyles.textFieldHintText2,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
