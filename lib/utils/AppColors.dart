import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //color for common themes (ALG)
  static const Color primaryColor = const Color(0xFF4eda60);
  static const Color primaryDarkColor = const Color(0xFF23E725);
  static const Color backgroundColor = const Color(0xFF183034);
  static const Color textDisableColor = const Color(0xFFffffff);
  static const Color iconDisableColor = const Color(0xFFffffff);
  static const Color instaBGColor = const Color(0xFF8a3ab9);
  static const Color instaBGColor1 = const Color(0xFFe95950);
  static const Color twitterBGColor = const Color(0xFF00acee);
  static const Color facebookBGColor = const Color(0xFF4267B2);
  static const Color snapChatBGColor = const Color(0xFFFEFC00);
  static const Color bottomBGColor = const Color(0xFF0c0d0c);

  static const Color yellow = const Color(0xFFbd8e27);
  static const Color orangeColor = const Color(0xfff46438);
  static const Color white = const Color(0xFFffffff);
  static const Color black = const Color(0xFF183034);
  static const Color darkGray = const Color(0xFF232323);
  static const Color dividerColor = const Color(0xFFE3E9EC);
  static const Color hintColor = const Color(0xFF979a9d);
  static const Color bgColor = const Color(0xFF424242);

  static const Color redColor = const Color(0xFFd41104);
  static const Color greenColor = const Color(0xFF008000);



  static const LinearGradient instaBGGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        AppColors.instaBGColor,
        AppColors.instaBGColor1
      ]);


}
