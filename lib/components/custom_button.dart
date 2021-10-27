import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final VoidCallback? onPress;
  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final double? width;
  final double? height;

  const ButtomCustom(
      {Key? key,
      this.onPress,
      this.backgroundColor,
      this.textColor,
      this.text,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(text!),
          ),
        ),
      ),
    );
  }
}
