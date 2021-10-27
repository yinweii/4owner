import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const double fontSize_10 = 13;
  static const double fontSize_11 = 13;
  static const double fontSize_12 = 14;
  static const double fontSize_13 = 14;
  static const double fontSize_14 = 14;
  static const double fontSize_16 = 16;
  static const double fontSize_20 = 20;
  static const double fontSize_24 = 24;

  static const TextStyle defaultRegular = TextStyle(
    color: AppColors.text,
    fontWeight: FontWeight.normal,
    fontSize: fontSize_14,
    fontFeatures: [
      FontFeature.tabularFigures(),
    ],
  );

  static final TextStyle defaultBold = defaultRegular.copyWith(
    fontWeight: FontWeight.bold,
  );
}
