import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:owner_app/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const double fontSize_10 = 10;
  static const double fontSize_11 = 11;
  static const double fontSize_12 = 12;
  static const double fontSize_13 = 13;
  static const double fontSize_14 = 14;
  static const double fontSize_15 = 15;
  static const double fontSize_16 = 16;
  static const double fontSize_18 = 18;
  static const double fontSize_20 = 20;
  static const double fontSize_24 = 24;
  static const double fontSize_28 = 28;
  static const double fontSize_29 = 29;

  // static TextStyle defaultRegular400 = GoogleFonts.roboto(
  //   fontSize: fontSize_16,
  //   fontWeight: FontWeight.w400,
  // );
  static TextStyle defaultRegular400 = TextStyle(
    fontSize: fontSize_16,
    fontWeight: FontWeight.w400,
  );
  // static TextStyle defaulLato = GoogleFonts.lato(
  //   fontSize: fontSize_16,
  //   fontWeight: FontWeight.w400,
  // );
  static TextStyle defaulLato = TextStyle(
    fontSize: fontSize_16, 
    fontWeight: FontWeight.w400,
  );
  // static TextStyle defaultFont = GoogleFonts.roboto(
  //   fontSize: fontSize_12,
  //   fontWeight: FontWeight.w300,
  // );
  static TextStyle defaultFont = TextStyle(
    fontSize: fontSize_12,
    fontWeight: FontWeight.w300,
  );

  // static TextStyle defaultBold = defaultRegular400.copyWith(
  //   fontWeight: FontWeight.bold,
  //   fontSize: fontSize_16,
  // );
  static TextStyle defaultBold = TextStyle( 
    fontWeight: FontWeight.bold,
    fontSize: fontSize_16,
  );
  // static TextStyle defaultBoldAppBar = defaultRegular400.copyWith(
  //   fontWeight: FontWeight.bold,
  //   fontSize: fontSize_20,
  //   color: AppColors.white,
  // );
  static TextStyle defaultBoldAppBar = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: fontSize_20,
    color: AppColors.white,
  );
}
