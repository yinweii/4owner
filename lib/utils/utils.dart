import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static double sizeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double sizeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  //
  static Future navigatePage(BuildContext context, Widget widget,
      {bool rootNavigator = false}) async {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .push(CupertinoPageRoute(
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

  static String convertPrice(var price) {
    var f = NumberFormat("#,###", "vi_VI");
    price = f.format(price);
    return price;
  }

  static void showToast(String? message, {bool isLong: false}) {
    if (message != null) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);
    }
  }
}
