import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  DialogUtil._();
  static void showLoading(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          );
        });
  }

  static void showError(BuildContext context, String? error,
      {Function? onPress}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          content: Text(error!),
          actions: [
            TextButton(
              onPressed: () {
                if (onPress == null) {
                  Navigator.pop(context);
                } else {
                  onPress();
                }
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void cupertioDialog({
    BuildContext? context,
    String? title,
    String? content,
    VoidCallback? yesAction,
  }) {
    showCupertinoDialog(
      context: context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: Text(content ?? ''),
          actions: [
            CupertinoDialogAction(
              child: Text("YES"),
              onPressed: () {
                yesAction!();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
