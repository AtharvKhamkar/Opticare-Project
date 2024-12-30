// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'package:flutter/material.dart';

import '../Colors/app_colors.dart';

///This class is used to store all the neccessary TextStyles required in an app
class TextStyles {
  static const TextStyle titles = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle headLine1 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 26,
      fontWeight: FontWeight.w500,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle headLine2 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle headLine2_Bold = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle headLine3 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      color: Color.fromRGBO(176, 190, 197, 1));

  static const TextStyle headLine4 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 12,
      fontWeight: FontWeight.w900,
      height: 18 / 13,
      color: Color.fromRGBO(176, 190, 197, 1));

  static const TextStyle headLine5 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 2,
      color: Color.fromRGBO(176, 190, 197, 1));

  static const TextStyle defaultText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 14.5,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle textFieldTitles = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      color: Color.fromRGBO(176, 190, 197, 1));

  static const TextStyle textFieldHintText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 18 / 14,
      color: Color.fromRGBO(187, 186, 186, 1));

  static const TextStyle textFieldHintText2 = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle ButtonText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle TileText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 13,
      color: Colors.white);

  static const TextStyle TileSubtitleText = TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 24 / 14,
      color: Color.fromRGBO(176, 190, 197, 1));

  static const TextStyle purpleText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 13,
      color: AppColors.primaryColor);

  static const TextStyle errorAlertText = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 18 / 13,
      color: Colors.red);

  static const TextStyle appBarTitle = TextStyle(
      fontFamily: 'SF Pro',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 24 / 18,
      color: Color.fromRGBO(187, 186, 186, 1));
}
