import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColorBackground = Color(0xFFFFFFFF);

  //Text Colors
  static const Color textColor = Color(0xFF000000);
  static const Color accentColor = Color(0xFF0C89D2);
  static const Color darkTextColor = Color(0xFF1A1A1A);
  static  const Color lightTextColor = Color(0xFFA1A1A1);

  //Action Colors
  static const Color disabledColor = Color(0xFFA1A1A1);
  static const Color borderColor = Color(0xFFA1A1A1);
  static const Color circleBorderColor = Color(0xFFA1A1A1);
  static const Color textBorderColor = Color(0xFFA1A1A1);
  static const Color textFieldColorOld = Colors.transparent;
  static const Color textFieldColor = Colors.transparent;

  //Other Colors
  static const Color red = Color(0xFFFF1F1F);
  static const Color green = Color(0xFF1FFF1F);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

  static const int _primaryColorValue = 0xFF022B69;

  static const MaterialColor primaryColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFE6F2FF),
      100: Color(0xFFB3D6FF),
      200: Color(0xFF80B9FF),
      300: Color(0xFF4D9CFF),
      400: Color(0xFF1A80FF),
      500: Color(_primaryColorValue),
      600: Color(0xFF002A4D),
      700: Color(0xFF001F3A),
      800: Color(0xFF00142A),
      900: Color(0xFF000A1A),
    },
  );
}
