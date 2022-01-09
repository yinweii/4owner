import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/constants/app_text.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({
    required this.label,
    this.buttonColor,
    required this.onPressed,
  });

  final String? label;
  final Color? buttonColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: onPressed,
        child: Text(
          label ?? '',
          style: AppTextStyles.defaultBold.copyWith(
            fontSize: AppTextStyles.fontSize_14,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
