import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///Currently hardcoded supplement section on the History Screen
// ignore: camel_case_types
class supplementSection extends StatelessWidget {
  ///constructor of the supplementSection class
  const supplementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No supplement recommended',
        style: TextStyles.headLine2,
      ),
    );
    // const SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       supplementTile(
    //           title: 'Omega 3',
    //           subtitle: '2 capsules',
    //           period: 'Before Breakfast'),
    //       supplementTile(
    //           title: 'Solgar Vitamin C',
    //           subtitle: '2 pills',
    //           period: 'After Breakfast'),
    //       supplementTile(
    //           title: 'Solgar Vitamin C',
    //           subtitle: '2 pills',
    //           period: 'After Lunch')
    //     ],
    //   ),
    // );
  }
}
