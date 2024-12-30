import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///Currently hardcoded recommendation section on the History Screen
class RecommendationSection extends StatelessWidget {
  ///Constructor for the Recommendation section
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Recommendations',
        style: TextStyles.headLine2,
      ),
    );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       RecommendationTile(
    //           title: 'Vitamin E (VE) with Biological Drugs',
    //           subtitle: 'High fat diet',
    //           date: '14 Dec 2024',
    //           agoPeriod: '1mo 6d'),
    //       RecommendationTile(
    //           title: 'Vitamin D (VD)',
    //           subtitle: 'High fat diet',
    //           date: '14 Dec 2024',
    //           agoPeriod: '2mo 3w'),
    //     ],
    //   ),
    // );
  }
}
