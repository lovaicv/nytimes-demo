import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nytimes/core/app_string.dart';

/// Displays a simple dialog with a message and an "OK" button.
/// Android device will use AlertDialog while iOS device will use CupertinoAlertDialog
void showSimpleDialog(String message) {
  if (Get.isDialogOpen ?? false) Get.back();
  Get.dialog(
    GetPlatform.isIOS
        ? CupertinoAlertDialog(
            content: simpleDialogContent(message),
            actions: [simpleDialogActions()],
          )
        : AlertDialog(
            content: simpleDialogContent(message),
            actions: [simpleDialogActions()],
          ),
  );
}

/// Returns the content widget for the simple dialog.
simpleDialogContent(String message) {
  return Text(message);
}

/// Returns the actions widget for the simple dialog.
simpleDialogActions() {
  return TextButton(onPressed: () => Get.back(), child: Text(AppString.ok.tr));
}
