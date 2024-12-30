import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///This is widget is used while checking password criterias
class PasswordCriteriaWidget extends StatelessWidget {
  ///Constructor of the PasswordCriteriaWidget
  const PasswordCriteriaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR PASSWORD MUST CONTAIN',
          style: TextStyles.headLine4,
        ),
        const SizedBox(
          height: 8,
        ),
        buildValidationRow('Between 8 to 32 characters', false),
        buildValidationRow('1 uppercase letter', false),
        buildValidationRow('1 or more numbers', false),
        buildValidationRow('1 or more special characters', true),
      ],
    );
  }
}

///Widget for each creteria
Widget buildValidationRow(String text, bool isValid) {
  return Row(
    children: [
      Icon(
        size: 16,
        isValid ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isValid ? Colors.green : Colors.grey,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(text, style: TextStyles.headLine5)
    ],
  );
}
