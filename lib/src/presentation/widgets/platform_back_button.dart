import 'dart:io';

import 'package:flutter/material.dart';

///Custom widget for back functionality
class VizzhyPlatformBackButton extends StatelessWidget {
  ///on pressed function
  final VoidCallback onPress;

  ///Constructor
  const VizzhyPlatformBackButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: onPress,
          )
        : IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
            onPressed: onPress,
          );
  }
}
