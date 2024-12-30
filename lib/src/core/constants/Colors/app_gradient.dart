import 'package:flutter/material.dart';

///Gradient color used in some screens
class AppGradient {
  ///Gradient color for background
  static const LinearGradient mainBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFF222831),
      Color(0xFF000000),
      // Darker shade at the top
      // Mid-dark shade// Bottom shade
    ],
    stops: [0.0, 0.5028, 0.9958],
  );
}
