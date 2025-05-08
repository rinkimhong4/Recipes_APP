import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const MaterialColor neutral = MaterialColor(_neutral, <int, Color>{
    600: Color(_neutral),
    500: Color(0xFF484848),
    400: Color(0xFF797979),
    300: Color(0xFFA9A9A9),
    200: Color(0xFFD9D9D9),
    100: Color(0xFFFFFFFF),
  });
  static const int _neutral = 0xFF000000;

  static const MaterialColor primaryColor =
      MaterialColor(_primaryColor, <int, Color>{
        700: Color(0xFF31B057),
        600: Color(_primaryColor),
        500: Color(0xFF71B1A1),
        400: Color(0xFFAFD3CA),
        300: Color(0xFFA9A9A9),
        200: Color(0xFFDBEBE7),
        100: Color(0xFFF6FAF9),
        90: Color(0xFFEAF7EE),
      });
  static const int _primaryColor = 0xFF129575;

  static const MaterialColor secondaryColor =
      MaterialColor(_secondaryColor, <int, Color>{
        600: Color(_secondaryColor),
        500: Color(0xFFFFA61A),
        400: Color(0xFFFFBA4D),
        300: Color(0xFFFFCE80),
        200: Color(0xFFFFE1B3),
      });
  static const int _secondaryColor = 0xFFFF9C00;

  static const MaterialColor ratingColor = MaterialColor(
    _ratingColor,
    <int, Color>{600: Color(_ratingColor)},
  );
  static const int _ratingColor = 0xFFFFAD30;

  static const MaterialColor warningColor = MaterialColor(
    _warningColor,
    <int, Color>{600: Color(_warningColor), 500: Color(0xFF995E00)},
  );
  static const int _warningColor = 0xFF804E00;
}

class AppTextStyle {
  AppTextStyle._();

  static const String _fontFamily = 'Poppins';

  // --- Poppins Bold ---
  static TextStyle poppinsTitleBoldBig50({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 50,
    color: color ?? AppColors.neutral[100],
  );
  static TextStyle poppinsTitleBold48({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 48,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsHeaderBold30({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsLargeBold20({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsMediumBold18({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsNormalBold16({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsSmallBold14({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsSmallerBold11({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 11,
    color: color ?? AppColors.neutral[100],
  );

  // --- Poppins Regular ---
  static TextStyle poppinsTitleRegular50({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 50,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsHeaderRegular30({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 30,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsLargeRegular20({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsMediumRegular18({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsNormalRegular16({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsSmallRegular14({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: color ?? AppColors.neutral[100],
  );

  static TextStyle poppinsSmallerRegular11({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 11,
    color: color ?? AppColors.neutral[100],
  );
}
