

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({Key? key, this.name, this.onPress, this.color})
      : super(key: key);
  final String? name;
  final Color? color;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: Text(
            name ?? '',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
