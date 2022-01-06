import 'package:flutter/material.dart';
import 'package:owner_app/components/footer_button.dart';
import 'package:owner_app/constants/export.dart';

class TwoButtonsFooter extends StatelessWidget {
  const TwoButtonsFooter({
    Key? key,
    this.leftButtonLabel,
    this.rightButtonLabel,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
    this.backgroundColor,
    this.leftButtonColor,
    this.rightButtonColor,
  }) : super(key: key);

  final String? leftButtonLabel;
  final String? rightButtonLabel;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;
  final Color? backgroundColor;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      color: backgroundColor ?? AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: FooterButton(
              label: leftButtonLabel ?? '',
              buttonColor: leftButtonColor ?? const Color(0xFF8f9ab3),
              onPressed: onLeftButtonPressed!,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: FooterButton(
              label: rightButtonLabel,
              buttonColor: rightButtonColor,
              onPressed: onRightButtonPressed,
            ),
          ),
        ],
      ),
    );
  }
}
