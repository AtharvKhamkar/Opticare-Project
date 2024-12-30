import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/constants.dart';

class NutrientTile extends StatelessWidget {
  final String title;
  final String? value;
  final String goal;
  final bool isLast;
  final String? unit;
  final Color? color;

  const NutrientTile({
    super.key,
    required this.title,
    required this.value,
    required this.goal,
    required this.isLast,
    this.unit = 'g',
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyles.defaultText),
              Text(
                '$value/$goal$unit',
                style: TextStyles.defaultText.copyWith(color: color),
              )
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            thickness: 0.2,
          )
      ],
    );
  }
}
