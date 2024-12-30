import 'package:flutter/material.dart';

///This widget is used to display single support option
class SecurityOption extends StatelessWidget {
  ///title of the SecurityOption
  final String title;

  ///onTap function
  final Function() onTap;

  ///constructor of the securityOption
  const SecurityOption({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              // Apply your text styles here
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
