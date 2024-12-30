// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

class RecommendationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String agoPeriod;

  const RecommendationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.agoPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyles.headLine2),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.navigate_next_rounded),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            subtitle,
            style: TextStyles.appBarTitle,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Issue date: ',
                  style: TextStyles.appBarTitle,
                ),
                TextSpan(text: date, style: TextStyles.headLine2),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Text(
              agoPeriod,
              style:
                  TextStyles.headLine2.copyWith(fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
