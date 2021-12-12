import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    this.lable,
    this.hintext,
    this.requied = false,
    this.maxLenth,
    this.controller,
    this.type,
    this.maxline,
  }) : super(key: key);
  final String? lable;
  final bool? requied;
  final String? hintext;
  final int? maxLenth;
  final int? maxline;
  final TextEditingController? controller;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text('$lable'),
                requied!
                    ? Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : SizedBox.shrink()
              ],
            ),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintext ?? '',
              ),
              keyboardType: type,
              maxLines: maxline,
            )
          ],
        ),
      ),
    );
  }
}
