import 'package:flutter/material.dart';

// colors
class CustomColors {
  static const Color backgroundScreenColor = Color(0xffEEEEEE);
  static const Color red = Color(0xffD02026);
  static const Color green = Color(0xff1DB68B);
  static const Color grey = Color(0xff596466);
  static const Color lightGrey = Color.fromARGB(255, 129, 145, 148);
  static const Color lightAmber = Color.fromARGB(255, 255, 191, 0);
  static const Color deepAmber = Color.fromARGB(255, 195, 146, 0);
  static const Color dark = Color(0xff1C1F2E);
}

// text styles
class CustomTextStyle {
  static const introBodyLarge = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static final bottomNav = TextStyle(
    fontSize: 14,
    color: Colors.grey[700],
  );
  static const selectedBottomNav = TextStyle(
    fontSize: 14,
    color: CustomColors.dark,
  );

  static const darkSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: CustomColors.dark,
  );

  static const darkMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: CustomColors.dark,
  );

  static const darkLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: CustomColors.dark,
  );

  static const whiteSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const whiteMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const whiteLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

// base url
class BaseURL {
  static const baseUrl = 'https://shopbs.besenior.ir/api/v1';
  static const singUrl = 'http://startflutter.ir/api';
}
