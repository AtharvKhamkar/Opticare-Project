// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:flutter/material.dart';

///This AppColor is used to store all colors used in an app
class AppColors {
  static const Color primaryColor = Color(0xff8720cc);
  static const Color primaryColorDark = Color(0xFF1A161D);
  static const Color primaryColorLight = Color(0xFFBB86FC);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color darkBackgroundColor = Color(0xFF0F0F0F);
  static const Color accentColor = Color(0xFF03DAC6);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color grayTileColor = Color(0xFF272727);
  static const Color tileBackgroundColor = Color.fromRGBO(95, 87, 113, 0.16);
  static const Color appointmentTileColor = Color(0xFF1A161D);
  static const Color grayAppointmentTileColor = Color(0xFF8E8E93);
  static const Color blueColorDark = Color(0x80161616);
  static const Color bottomSheetColor = Color(0xFF161616);
  static const Color darkTileColor = Color(0xFF181818);
  static const Color sheetButtonBgColor = Color(0xFFE3E6EA);
  static const Color nutrientsTileColor = Color(0x1FAEAEAE);

  /// gives you a random color
  static Color getRandomColor() {
    final firstRandomInt = Random().nextInt(100);
    final secondRandomInt = Random().nextInt(100);
    final thirdRandomInt = Random().nextInt(100);
    return Color.fromRGBO(firstRandomInt, secondRandomInt, thirdRandomInt, 1);
  }
}
