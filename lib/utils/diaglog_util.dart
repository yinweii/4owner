import 'package:flutter/material.dart';

class DialogUtil {
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
}
