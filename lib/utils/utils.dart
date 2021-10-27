import 'package:flutter/material.dart';

class Utils {
  static double sizeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double sizeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  //
  static Future navigatePage(BuildContext context, Widget widget,
      {bool rootNavigator = false}) async {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static Future navigateReplace(BuildContext context, Widget widget,
      {bool rootNavigator = false}) async {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .pushReplacement(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }
}
